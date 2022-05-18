#include <iostream>
#include <cstdlib>
#include <unistd.h>
#include <limits.h>
#include <chrono>
#include <ctime>
#include <iomanip>
#include <sys/ioctl.h>

#include <git2/global.h>
#include <git2/repository.h>

// #define SET_FG(R, G, B) "\x1B[38;2;" #R ";" #G ";" #G "m"
// #define SET_BG(R, G, B) "\x1B[48;2;" #R ";" #G ";" #G "m"
#define RESET() "\x1B[0m"

using namespace std;

// g++ -Wall -Wextra -o prompt -O2 ./prompt.cpp

// https://libgit2.org/docs/guides/101-samples/
class Git
{
private:
    const string &_path;
    bool _isGitRepo = false;

public:
    Git(const string &path)
        : _path(path)
    {
        git_libgit2_init();

        git_buf git_root = {NULL};
        // git_repository repo = {NULL};

        if (git_repository_discover(&git_root, path.c_str(), 0, NULL) == 0)
            _isGitRepo = true;
        else
            _isGitRepo = false;

        git_buf_free(&git_root);
    }

    // ~Git()
    // {
    //     git_libgit2_shutdown();
    // }

    bool is_git_repo()
    {
        return _isGitRepo;
    }

    bool is_clean()
    {
    }
};

int main()
{
    char hostname[HOST_NAME_MAX + 1];

    if (gethostname(hostname, HOST_NAME_MAX) != 0)
    {
        cerr << "error reading hostname" << endl;
        return -1;
    }

    auto pwd = getenv("PWD");
    auto home = getenv("HOME");
    auto user = getenv("USER");

    struct winsize terminal_size;
    ioctl(STDOUT_FILENO, TIOCGWINSZ, &terminal_size);

    // yellow 182, 136, 0
    // green  98, 150, 85
    // blue   32, 117, 199

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
        << "\x1B[49m"              // bg reset
        << "\x1B[38;2;32;117;199m" // fg blue
        << "\uE0B0";

    Git git(".");

    if (git.is_git_repo())
    {
        if (git.is_clean())
            cout << "\x1B[48;2;182;136;0m";
        else
            cout << "\x1B[48;2;98;150;85m";
        cout << "GIT";
    }

    cout << RESET()
         << endl;

    const time_t now = time(0);
    tm *local_time = localtime(&now);
    cout
        << setfill('0') << setw(2)
        << local_time->tm_hour
        << ":" << local_time->tm_min
        << ":" << local_time->tm_sec
        << endl;

    return 0;
}
