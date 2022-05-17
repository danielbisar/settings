public static class CLI
{
    public static void WriteColorBg(this TextWriter sw, byte[] color)
    {
        sw.Write("\u001b[48;2;");
        sw.WriteColorSequence(color);
    }

    public static void WriteColorFg(this TextWriter sw, byte[] color)
    {
        sw.Write("\u001b[38;2;");
        sw.WriteColorSequence(color);
    }

    public static void WriteResetFg(this TextWriter sw)
    {
        sw.Write("\u001b[39m");
    }

    public static void WriteResetBg(this TextWriter sw)
    {
        sw.Write("\u001b[49m");
    }

    private static void WriteColorSequence(this TextWriter sw, byte[] color)
    {
        sw.Write(color[0]);
        sw.Write(';');
        sw.Write(color[1]);
        sw.Write(';');
        sw.Write(color[2]);
        sw.Write('m');
    }

    public static byte[] GetColor(ReadOnlySpan<char> hexColor)
    {
        byte[] result = new byte[3];
        result[0] = byte.Parse(hexColor.Slice(0, 2), System.Globalization.NumberStyles.HexNumber);
        result[1] = byte.Parse(hexColor.Slice(2, 2), System.Globalization.NumberStyles.HexNumber);
        result[2] = byte.Parse(hexColor.Slice(4, 2), System.Globalization.NumberStyles.HexNumber);

        return result;
    }

    public static void ResetAttribute(this TextWriter sw)
    {
        sw.Write("\u001b[0m");
    }
}
