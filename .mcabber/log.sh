#!/bin/bash
clean_me() {
    sleep 1;
    shred "$dir/$file"
    rm "$dir/$file"
}
dir="$HOME/.mcabber"
file=".mcabberrc"
cat "$dir/mcabberrc" > "$dir/$file"
cat "$dir/logins/$1" >> "$dir/$file"
clean_me &
mcabber -f "$dir/$file"
