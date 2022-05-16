public class CLI
{
    public static void WriteSetColorBg(ReadOnlySpan<char> hexColor)
    {
        Console.Write("\u001b[48;2;");
        WriteColorSequence(hexColor);
    }

    public static void WriteSetColorFg(ReadOnlySpan<char> hexColor)
    {
        Console.Write("\u001b[38;2;");
        WriteColorSequence(hexColor);
    }

    public static void WriteResetColorFg()
    {
        Console.Write("\u001b[39m");
    }

    public static void WriteResetColorBg()
    {
        Console.Write("\u001b[49m");
    }

    private static void WriteColorSequence(ReadOnlySpan<char> hexColor)
    {
        Console.Write(byte.Parse(hexColor.Slice(0, 2), System.Globalization.NumberStyles.HexNumber));
        Console.Write(';');
        Console.Write(byte.Parse(hexColor.Slice(2, 2), System.Globalization.NumberStyles.HexNumber));
        Console.Write(';');
        Console.Write(byte.Parse(hexColor.Slice(4, 2), System.Globalization.NumberStyles.HexNumber));
        Console.Write('m');
    }
}
