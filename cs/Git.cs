using System.Diagnostics;

public static class Git
{
    public static bool IsRepo(string path)
    {
        using var process = RunGit("rev-parse");
        return (process?.ExitCode ?? 1) == 0;
    }

    public static string GetCurrentBranch(string path)
    {
        using var process = RunGit("branch", "--show-current");
        return process?.StandardOutput.ReadLine() ?? "";
    }

    public static bool IsClean(string path)
    {
        using var process = RunGit("diff", "--quiet");
        return (process?.ExitCode ?? 0) == 0;
    }

    public static int GetOutgoingCommits(string path, string branch)
    {
        using var process = RunGit("rev-list", "--count", "origin/" + branch + ".." + branch);
        return int.Parse(process?.StandardOutput.ReadToEnd() ?? "0");
    }

    public static int GetIncommingCommits(string path, string branch)
    {
        using var process = RunGit("rev-list", "--count", branch + "..origin/" + branch);
        return int.Parse(process?.StandardOutput.ReadToEnd() ?? "0");
    }

    private static Process? RunGit(params string[] cmd)
    {
        var processStartInfo = new ProcessStartInfo();
        processStartInfo.FileName = "git";
        processStartInfo.ArgumentList.AddRange(cmd);
        processStartInfo.RedirectStandardError = true;
        processStartInfo.RedirectStandardOutput = true;

        var process = Process.Start(processStartInfo);

        if (process == null)
            return null;

        process.WaitForExit();
        return process;
    }
}
