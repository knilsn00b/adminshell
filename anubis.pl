#creator Pranjal Tiwari
#email: pranjaltiwariit@gmail.com
#Liscence GNU v2


print "\nEnter Options to invoke. . . . . . . . . . . . \n\n\n";
print "1.Chat service[run server script on server first]\n2.File Transfer\n3.Telnet\n";
chown($ch=<STDIN>);
if($ch==1)
{
##################chat script
use IO::Socket;
print "\nEnter the hostname/ip: ";
chown($host=<STDIN>); 
$socket = IO::Socket::INET->new
(
    PeerAddr => "$host",
    PeerPort => 1247,
    Proto    => "tcp",
    Type     => SOCK_STREAM
) or die "Could not create client.\n";
unless (defined($child_pid = fork())) {die "Can not fork.\n"};
if (defined($child_pid = fork()))
 {
    print "Connection Stablished . . . \n";
 }
if ($child_pid) {
    while ($line = <>) {
        print $socket $line;
    }
} else {
    while($line = <$socket>) {
        print "Read this from server: $line";
    }
 }
}

###################ftp script

elsif($ch==2)
{

use Net::FTP;

print "Starting the FTP service . . . .\n";

print "Enter the Hostname/ip : ";
chomp($host=<STDIN>);

$ftp = Net::FTP->new("$host", Timeout => 30)
        or die "Could not connect.\n";

print "Enter the User :";
chomp($user=<STDIN>);

print "Enter the Password :";
chomp($pass=<STDIN>);

$ftp->login("$user", "$pass")
        or die "Could not log in.\n";

if(login)
 {
    print "Connected Successfully . . . .\n";
 }

#$ftp->cwd('/home/knils/Desktop')
 #     or die "Can not change Directory";

while(1)
{        
 print "ftp> ";
 chomp($fn=<STDIN>);
 if ($fn eq "bye")
  {
     exit 0;
  }
($fn1,$fn2)= split / +/, $fn; 
$ftp->$fn1("$fn2")
        or print "Invalid Operation\n";
}
}

###############Telnet script

elsif($ch==3)
{

print "Starting Telnet service . . . .\n";

print "Enter the Hostname/ip : ";
chomp($host=<STDIN>);

use Net::Telnet;

$telnet = Net::Telnet->new
( 
    Timeout => 90,
  #  Prompt  => '%', 
    Host => "$host" 
);

print "Enter the User :";
chomp($user=<STDIN>);

print "Enter the Password :";
chomp($pass=<STDIN>);

$telnet->login("$user", "$pass");

if(login)
 {
    print "Connected Successfully . . . .\n";
 }

#$telnet->cmd("cd /home/knils/Desktop");

while(1)
{
 chomp($n=<STDIN>);
 @listing = $telnet->cmd("$n");
 print "@listing ";
}
$telnet->close;
}

else
{
 print "You entered bad choice . .";
 exit 0;
}
