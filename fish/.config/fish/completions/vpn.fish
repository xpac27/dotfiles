complete -c vpn -f
complete -c vpn -n 'test (count (commandline -opc)) -eq 1' -a se -d 'Sweden (default)'
complete -c vpn -n 'test (count (commandline -opc)) -eq 1' -a fr -d France
complete -c vpn -n 'test (count (commandline -opc)) -eq 1' -a uk -d 'United Kingdom'
complete -c vpn -n 'test (count (commandline -opc)) -eq 1' -a us -d 'United States'
complete -c vpn -n 'test (count (commandline -opc)) -eq 1' -a pl -d Poland
complete -c vpn -n 'test (count (commandline -opc)) -eq 1' -a off -d Disconnect
complete -c vpn -n 'test (count (commandline -opc)) -eq 1' -a status -d 'Show service state'
