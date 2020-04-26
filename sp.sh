sp() {
    local SP_VERSION="0.1.0"
    if [ $# -lt 2 ]
    then
        case "$1" in
            "-h"|"--help")
                cat <<- EOF
Usage:
    $0 SPLIT SPLIT ... SPLIT PANE

SPLIT:
    three-chars string with direction (v|h) and percentage
 PANE:
    selected pane at the end of the split

Examples:
    $ $0 v20 h50 0
    $ $0 v25 h33 h33 0
EOF
                return 0
                ;;
            "-v"|"--version")
                echo $SP_VERSION
                return 0
                ;;
            *)
                echo $($0 -h)
                return 1
                ;;
        esac
    fi
    PANESELECT=${@:$#}

    for sp in ${@:1:${#}-1}
    do
        eval "tmux split-window -${sp:0:1}p ${sp:1:3}"
    done
    eval "tmux select-pane -t$PANESELECT"
}

