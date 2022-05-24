﻿var pwd = Environment.GetEnvironmentVariable("PWD") ?? "";
var cwd = PathUtils.ReplaceHomeWithTilde(pwd);
var cwdFileInfo = new FileInfo(pwd);
var isLink = cwdFileInfo.Attributes.HasFlag(FileAttributes.ReparsePoint);

var isGitRepo = Git.IsRepo(".");
var isGitClean = true;

if (isGitRepo)
{
    isGitClean = Git.IsClean(".");
}

var time = DateTime.Now.ToString("H:mm:ss");
var sw = Console.Out;

var black = CLI.GetColor("000000");
var yellow = CLI.GetColor("B68800");
var green = CLI.GetColor("629655");
var blue = CLI.GetColor("2075C7");
var gitBgColor = green;

sw.WriteColorBg(yellow);
sw.WriteColorFg(black);
sw.Write(Environment.MachineName);

sw.WriteColorBg(green);
sw.WriteColorFg(yellow);
sw.Write("\uE0B8");

sw.WriteColorBg(green);
sw.WriteColorFg(black);
sw.Write(Environment.UserName);

sw.WriteColorBg(blue);
sw.WriteColorFg(green);
sw.Write("\uE0B8");

sw.WriteColorBg(blue);
sw.WriteColorFg(black);

sw.Write(cwd);

if (isLink)
{
    sw.Write(" \uF178 ");
    sw.Write(PathUtils.ReplaceHomeWithTilde(cwdFileInfo.LinkTarget ?? ""));
}

if (isGitRepo)
{
    if (!isGitClean)
        gitBgColor = yellow;

    sw.WriteColorBg(gitBgColor);
}
else
    sw.WriteResetBg();

sw.WriteColorFg(blue);
sw.Write('\uE0B0');

if (isGitRepo)
{
    var branch = Git.GetCurrentBranch(".");
    var outgoingCommits = Git.GetOutgoingCommits(".", branch);
    var incommingCommits = Git.GetIncommingCommits(".", branch);

    sw.WriteColorBg(gitBgColor);
    sw.WriteColorFg(black);
    sw.Write("\uE725 ");
    sw.Write(branch);

    sw.Write(' ');
    sw.Write(outgoingCommits);
    sw.Write("\uF55D ");
    sw.Write(incommingCommits);
    sw.Write("\uF545 ");

    if (isGitClean)
        sw.Write("\uF00C ");
    else
        sw.Write("\uF692 ");

    sw.WriteResetBg();
    sw.WriteColorFg(gitBgColor);
    sw.Write('\uE0B0');
}

sw.ResetAttributes();

Console.CursorLeft = Console.BufferWidth - 9;
sw.WriteColorFg(blue);
sw.WriteResetBg();
sw.Write('\uE0B6');
sw.WriteColorBg(blue);
sw.WriteColorFg(black);
sw.Write(time);
sw.ResetAttributes();

Console.WriteLine();