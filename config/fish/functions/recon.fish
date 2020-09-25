function recon
    if test (count $argv) -lt 2 
        echo "Usage: recon <domain> <directory>"
    else
        cd ~/Documents/
        mkdir -p recon/$argv[2]; cd recon/$argv[2]
        subfinder -d $argv[1] -silent | sort -u | httprobe | tee -a hosts;
        amass enum -d $argv[1] -nf hosts;
        cat hosts | aquatone -ports xlarge -out report-$argv[1];
        nuclei -l hosts -t ~/nuclei-templates/{cves,subdomain-takeover,files,vulnerabilities,security-misconfiguration} -o nuclei-report -pBar
        jaeles scan -c 50 -s /tmp/jaeles-signatures/{cves,common,passive} -U hosts -L 50 -v -G --html jaeles-report
    end
end
