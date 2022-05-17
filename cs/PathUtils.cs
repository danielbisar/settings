
public static class PathUtils
{
    public static string ReplaceHomeWithTilde(string path)
    {
        var home = Environment.GetFolderPath(Environment.SpecialFolder.Personal);

        if (home == null)
            return path;

        return '~' + path.Substring(home.Length, path.Length - home.Length);
    }
}
