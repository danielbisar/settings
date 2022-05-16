var cwd = (ReadOnlySpan<char>)(Environment.GetEnvironmentVariable("PWD") ?? "");
var home = Environment.GetEnvironmentVariable("HOME") ?? "";
var skipHome = false;

if (cwd.StartsWith(home))
    skipHome = true;

CLI.WriteSetColorBg("B68800");
CLI.WriteSetColorFg("000000");
Console.Write(Environment.MachineName);

CLI.WriteSetColorBg("629655");
CLI.WriteSetColorFg("B68800");
Console.Write("\uE0B8");

CLI.WriteSetColorBg("629655");
CLI.WriteSetColorFg("000000");
Console.Write(Environment.GetEnvironmentVariable("USER"));

CLI.WriteSetColorBg("2075C7");
CLI.WriteSetColorFg("629655");
Console.Write("\uE0B8");

CLI.WriteSetColorBg("2075C7");
CLI.WriteSetColorFg("000000");

if (skipHome)
{
    Console.Out.Write('~');
    Console.Out.Write(cwd.Slice(home.Length));
}
else
    Console.Out.Write(cwd);

CLI.WriteResetColorBg();
CLI.WriteSetColorFg("2075C7");
Console.Write("\uE0B0");

Console.Write("\u001b[0m");

Console.CursorLeft = Console.BufferWidth - 9;

CLI.WriteSetColorFg("2075C7");
CLI.WriteResetColorBg();
Console.Write('\uE0B6');
CLI.WriteSetColorBg("2075C7");
CLI.WriteSetColorFg("000000");
Console.Write(DateTime.Now.ToString("H:mm:ss"));
Console.Write("\u001b[0m");
Console.WriteLine();
