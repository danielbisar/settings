#include <iostream>
#include <cstdlib>
#include <unistd.h>
#include <limits.h>
#include <chrono>
#include <ctime>
#include <iomanip>
#include <sys/ioctl.h>
#include <cstring>
#include <filesystem>

#include "git.hpp"
#include "powerline.hpp"

using namespace std;

string getEnvVar(const char *name, const string &defaultValue = "")
{
    auto value = getenv(name);

    if (value == NULL)
        return defaultValue;

    return string(value);
}

int main()
{
    struct winsize terminal_size;
    ioctl(STDOUT_FILENO, TIOCGWINSZ, &terminal_size);

    const time_t now = time(0);
    tm *local_time = localtime(&now);

    cout << "\x1B["
         << (terminal_size.ws_col - 9)
         << "C";

    cout
        << "\x1B[38;2;32;117;199m" // fg blue
        << "\x1B[49m"              // bg reset
        << "\uE0B6"
        << "\x1B[38;2;0;0;0m"      // fg black
        << "\x1B[48;2;32;117;199m" // fg blue
        ;

    cout
        << setfill('0') << setw(2)
        << local_time->tm_hour
        << ":"
        << setfill('0') << setw(2)
        << local_time->tm_min
        << ":"
        << setfill('0') << setw(2)
        << local_time->tm_sec;

    // move cursor back to the beginning
    cout << "\x1B["
         << terminal_size.ws_col
         << "D";

    char hostname[HOST_NAME_MAX + 1];

    if (gethostname(hostname, HOST_NAME_MAX) != 0)
    {
        cerr << "error reading hostname" << endl;
        return -1;
    }

    auto pwd = getEnvVar("PWD");
    auto home = getEnvVar("HOME");
    auto user = getEnvVar("USER");

    if (user.length() == 0)
        user = "?UNSET?";

    // replace HOME in PWD by ~
    if (pwd.rfind(home, 0) == 0)
        pwd.replace(0, home.length(), "~");

    if (std::filesystem::is_symlink(pwd))
        pwd += " \uF178 " + std::filesystem::read_symlink(pwd).string();

    Git git(".");

    Powerline line;

    line.setSeparator("\uE0B8");
    line.addSegment(hostname, "182;136;0", "0;0;0");
    line.addSegment(user, "98;150;85", "0;0;0");
    line.addSegment(pwd, "32;117;199", "0;0;0")->end = "\uE0B0";

    if (git.is_git_repo())
    {
        auto bgColor = git.is_clean() ? "182;136;0" : "98;150;85";
        auto branch_name = git.get_current_branch_name();
        line.addSegment(" \uE725 " + branch_name, bgColor, "0;0;0")->end = "\u2588";

        // TODO implementation + outgoing, incoming commit count
    }

    line.write(cout);

    return 0;
}
