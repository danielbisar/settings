use chrono::{Local, Timelike};
use crossterm::{cursor, execute};
use owo_colors::OwoColorize;
use std::{env, fs, io::stdout};

fn get_host_name() -> String {
    return hostname::get()
        .expect("could not read hostname")
        .into_string()
        .expect("could not convert ostring to string");
}

fn get_user_name() -> String {
    if cfg!(windows) {
        return env::var("USERNAME").expect("could not get user name");
    } else {
        let result = env::var("USER");
        if result.is_ok() {
            return result.unwrap();
        } else {
            return "".to_string();
        }
    }
}

fn get_current_working_dir() -> String {
    let pathbuf = env::current_dir().expect("cannot get current directory");
    let is_symlink = pathbuf.is_symlink();
    let dir = pathbuf.clone().into_os_string().into_string().unwrap();

    if is_symlink {
        let target_dir = fs::read_link(pathbuf)
            .expect("could not get target of symlink")
            .into_os_string()
            .into_string()
            .unwrap();
        return dir + "  " + &target_dir;
    } else {
        return dir;
    }
}

fn get_terminal_width() -> u16 {
    return crossterm::terminal::size().unwrap().0;
}

fn move_cursor_relative_to_right(relative_pos: u16) {
    let terminal_width = get_terminal_width();
    execute!(
        stdout(),
        cursor::MoveToColumn(terminal_width - relative_pos)
    )
    .expect("could not move cursor");
}

fn get_home_dir() -> String {
    return match env::home_dir() {
        Some(path) => path.into_os_string().into_string().unwrap(),
        None => String::from(""),
    };
}

fn main() {
    let host_name = get_host_name();
    let user_name = get_user_name();
    let home_dir = get_home_dir();
    let mut working_dir = get_current_working_dir();

    if working_dir.starts_with(&home_dir) {
        working_dir.replace_range(0..home_dir.len(), "~");
    }

    let repository = git2::Repository::discover(".");

    let repo_opened = match repository {
        Ok(_) => true,
        Err(_) => false,
    };

    print!(
        "{}{}{}{}{}",
        host_name.bg_rgb::<182, 138, 0>().black(),
        "".bg_rgb::<98, 150, 85>().fg_rgb::<182, 138, 0>(),
        user_name.bg_rgb::<98, 150, 85>().black(),
        "".bg_rgb::<32, 117, 199>().fg_rgb::<98, 150, 85>(),
        working_dir.bg_rgb::<32, 117, 199>().black()
    );

    if repo_opened {
        print!("{}", "".fg_rgb::<32, 117, 199>().bg_rgb::<182, 138, 0>());

        let repo = repository.unwrap();
        let repo_head = repo.head().expect("could not get HEAD");
        let name = repo_head.name().unwrap();

        // refs/heads/ = 11
        let branch_name = &name[11..name.len()];

        // █

        print!(
            "{}{}{}",
            "  ".bg_rgb::<182, 138, 0>().black(),
            branch_name.bg_rgb::<182, 138, 0>().black(),
            " ".bg_rgb::<182, 138, 0>().black()
        );
    } else {
        print!("{}", "".fg_rgb::<32, 117, 199>())
    }

    move_cursor_relative_to_right(9);

    let now = Local::now();
    let str_now = format!("{:02}:{:02}:{:02}", now.hour(), now.minute(), now.second());

    print!("{}", "".fg_rgb::<32, 117, 199>());
    println!("{}", str_now.bg_rgb::<32, 117, 199>().black());
}
