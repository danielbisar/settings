use chrono::{Timelike, Utc};
use crossterm::{
    cursor::{self},
    execute,
};
use owo_colors::OwoColorize;
use std::{env, io::stdout};

fn main() {
    let host_name_os_string = hostname::get().expect("could not read hostname");
    let host_name_str = host_name_os_string
        .into_string()
        .expect("could not convert ostring to string");

    // TODO $USER under linux
    let user = env::var("USERNAME").expect("could not get user name");

    let pwd = env::current_dir()
        .unwrap()
        .into_os_string()
        .into_string()
        .unwrap();

    print!(
        "{}{}{}{}{}{}",
        host_name_str.bg_rgb::<182, 138, 0>().black(),
        "".bg_rgb::<98, 150, 85>().fg_rgb::<182, 138, 0>(),
        user.bg_rgb::<98, 150, 85>().black(),
        "".bg_rgb::<32, 117, 199>().fg_rgb::<98, 150, 85>(),
        pwd.bg_rgb::<32, 117, 199>().black(),
        "".fg_rgb::<32, 117, 199>()
    );

    let columns = crossterm::terminal::size().unwrap().0;
    execute!(stdout(), cursor::MoveToColumn(columns - 9)).expect("bla");

    let now = Utc::now();

    print!("{}", "".fg_rgb::<32, 117, 199>());

    let str_now = format!("{:02}:{:02}:{:02}", now.hour(), now.minute(), now.second());

    println!("{}", str_now.bg_rgb::<32, 117, 199>().black());
}
