function persist --description 'Attach to or create a persistent abduco Fish shell'
    abduco -f -e '^q' -A shell env ABDUCO_SESSION=shell fish --features=no-query-term
end
