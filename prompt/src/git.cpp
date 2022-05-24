#include "git.hpp"
#include <iostream>

// https://libgit2.org/docs/guides/101-samples/

Git::Git(const string &path)
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

bool Git::is_git_repo()
{
    return _isGitRepo;
}

bool Git::is_clean()
{
    return true;
}

const string Git::get_current_branch_name()
{
    // https://stackoverflow.com/questions/12132862/how-do-i-get-the-name-of-the-current-branch-in-libgit2
    git_reference *head_ref;
    git_reference_lookup(&head_ref, _repo, "HEAD");

    const char *symbolic_ref;
    symbolic_ref = git_reference_symbolic_target(head_ref);
    string result;

    // Skip leading "refs/heads/" -- 11 chars.
    if (symbolic_ref)
        result = &symbolic_ref[11];

    git_reference_free(head_ref);

    return result;
}
