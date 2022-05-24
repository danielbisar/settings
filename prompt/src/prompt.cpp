#include <iostream>
#include <cstdlib>
#include <unistd.h>
#include <limits.h>
#include <chrono>
#include <ctime>
#include <iomanip>
#include <sys/ioctl.h>
#include <cstring>

#include "git.hpp"

// #define SET_FG(R, G, B) "\x1B[38;2;" #R ";" #G ";" #G "m"
// #define SET_BG(R, G, B) "\x1B[48;2;" #R ";" #G ";" #G "m"
#define RESET() "\x1B[0m"

using namespace std;

// g++ -Wall -Wextra -o prompt -O2 ./prompt.cpp

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

    auto pwd = getenv("PWD");
    const char *home = getenv("HOME");
    const char *user = getenv("USER");

    if (user == nullptr)
        user = "?UNSET?";

    // TODO replace HOME in PWD by ~
    // TODO PWD is print link " \uF178 " + target
    // TODO is_clean implementation + outgoing, incoming commit count

    // yellow 182, 136, 0
    // green  98, 150, 85
    // blue   32, 117, 199

    const char *endBgColor = "\x1B[49m"; // bg reset

    Git git(".");

    if (git.is_git_repo())
    {
        if (git.is_clean())
            endBgColor = "\x1B[48;2;182;136;0m";
        else
            endBgColor = "\x1B[48;2;98;150;85m";
    }

    cout
        << "\x1B[38;2;0;0;0m"     // fg black
        << "\x1B[48;2;182;136;0m" // bg yellow
        << hostname
        << "\x1B[38;2;182;136;0m" // fg yellow
        << "\x1B[48;2;98;150;85m" // bg green
        << "\uE0B8"
        << "\x1B[38;2;0;0;0m" // fg black
        << user
        << "\x1B[38;2;98;150;85m"  // fg green
        << "\x1B[48;2;32;117;199m" // bg blue
        << "\uE0B8"
        << "\x1B[38;2;0;0;0m" // fg black
        << pwd
        << "\x1B[38;2;32;117;199m" // fg blue
        << endBgColor
        << "\uE0B0";

    if (git.is_git_repo())
    {
        cout << "\x1B[38;2;0;0;0m" // fg black
             << "\uE725 ";

        // TODO is clean implementation
        // if (git.is_clean())
        //     cout
        //         << "\x1B[48;2;182;136;0m";
        // else
        //     cout << "\x1B[48;2;98;150;85m";

        cout << git.get_current_branch_name() << " ";
    }

    cout << RESET()
         << endl;

    return 0;
}
