#!/bin/bash
# functions related to this repo

function db-update()
{
    pushd "$DB_SETTINGS_BASE" &> /dev/null || return
    
    if [ $DB_USE_HTTPS_FOR_PULL ]; then
        git pull origin-https main
    else
        git pull
    fi

    popd
    db-reload-env
}

function db-status()
{
    pushd "$DB_SETTINGS_BASE" &> /dev/null || return
    git status
    popd
}

function db-push()
{
    pushd "$DB_SETTINGS_BASE" &> /dev/null || return
    git push
    popd
}

function db-add-all()
{
    pushd "$DB_SETTINGS_BASE" &> /dev/null || return
    git add .
    popd

}

function db-commit()
{
    pushd "$DB_SETTINGS_BASE" &> /dev/null || return
    git commit "$@"
    popd

}

