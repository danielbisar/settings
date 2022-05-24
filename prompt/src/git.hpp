#pragma once

#include <string>
#include <git2/buffer.h>
#include <git2/global.h>
#include <git2/refs.h>
#include <git2/repository.h>

using namespace std;

// https://libgit2.org/docs/guides/101-samples/
class Git
{
private:
    const string &_path;
    const char *c_path;
    bool _isGitRepo = false;
    git_repository *_repo;

public:
    Git(const string &path);

    bool is_git_repo();
    bool is_clean();
    const string get_current_branch_name();
};
