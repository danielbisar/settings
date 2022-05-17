using System.Diagnostics;

public static class Git
{
    public static bool IsRepo(string path)
    {
        var processStartInfo = new ProcessStartInfo();
        processStartInfo.FileName = "git";
        processStartInfo.ArgumentList.Add("rev-parse");
        processStartInfo.RedirectStandardError = true;
        processStartInfo.RedirectStandardOutput = true;

        using (var process = Process.Start(processStartInfo))
        {
            if (process == null)
                return false;

            process.WaitForExit();
            return process.ExitCode == 0;
        }
    }

    public static string GetCurrentBranch(string path)
    {
        var processStartInfo = new ProcessStartInfo();
        processStartInfo.FileName = "git";
        processStartInfo.ArgumentList.Add("branch");
        processStartInfo.ArgumentList.Add("--show-current");
        processStartInfo.RedirectStandardError = true;
        processStartInfo.RedirectStandardOutput = true;

        using (var process = Process.Start(processStartInfo))
        {
            if (process == null)
                return "";

            process.WaitForExit();
            return process.StandardOutput.ReadLine() ?? "";
        }
    }

    public static bool IsClean(string path)
    {
        var processStartInfo = new ProcessStartInfo();
        processStartInfo.FileName = "git";
        processStartInfo.ArgumentList.Add("diff");
        processStartInfo.ArgumentList.Add("--quiet");
        processStartInfo.RedirectStandardError = true;
        processStartInfo.RedirectStandardOutput = true;

        using (var process = Process.Start(processStartInfo))
        {
            if (process == null)
                return true;

            process.WaitForExit();
            return process.ExitCode == 0;
        }
    }
}
