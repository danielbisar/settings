#include <iostream>
#include <cstdlib>
#include <unistd.h>
#include <limits.h>
#include <chrono>
#include <ctime>
#include <iomanip>
#include <sys/ioctl.h>

#include <git2/buffer.h>
#include <git2/global.h>
#include <git2/refs.h>
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
    const char *c_path;
    bool _isGitRepo = false;
    git_repository *_repo;

public:
    Git(const string &path)
        : _path(path), c_path(path.c_str()), _repo(nullptr)
    {
        git_libgit2_init();

        git_buf git_root = {NULL};
        // git_repository repo = {NULL};

        if (git_repository_discover(&git_root, c_path, 0, NULL) == 0)
        {
            _isGitRepo = true;

            auto r = git_repository_open(&_repo, git_root.ptr);

            if (r != 0)
                cerr << "cannot open repo" << endl;
        }
        else
            _isGitRepo = false;

        // git_buf_free(&git_root);
    }

    // TODO clean up resources, even if the os takes care,
    // when the program is closed it would be better to clean
    // them for later reusage
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
        return true;
    }

    const string get_current_branch_name()
    {
        // https://stackoverflow.com/questions/12132862/how-do-i-get-the-name-of-the-current-branch-in-libgit2
        git_reference *head_ref;
        git_reference_lookup(&head_ref, _repo, "HEAD");

        const char *symbolic_ref;
        symbolic_ref = git_reference_symbolic_target(head_ref);
        std::string result;

        // Skip leading "refs/heads/" -- 11 chars.
        if (symbolic_ref)
            result = &symbolic_ref[11];

        git_reference_free(head_ref);

        return result;
    }
};

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
    auto home = getenv("HOME");
    auto user = getenv("USER");

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
