function fish_right_prompt
    if set -q ABDUCO_SESSION
        set_color yellow
        printf '[%s]' $ABDUCO_SESSION
        set_color normal
    end
end
