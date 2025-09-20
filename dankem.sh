#!/bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Variable for the URL
BASE_URL="http://169.254.169.254/latest"

# Get token for metadata requests
TOKEN=$(curl -X PUT "$BASE_URL/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 3600" -s)

# Collect instance info and save to variables
LOCAL_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s "$BASE_URL/meta-data/local-ipv4")
AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s "$BASE_URL/meta-data/placement/availability-zone")
HOST_NAME=$(hostname -f)

# Create simple webpage and save to /var/www/html/index.html
# EOF marks where the HTML starts and stops basically
cat << EOF > /var/www/html/index.html
<!doctype html>
<html lang=\"en\" class=\"h-100\">
<head>
<title>This webpage is owned by ? </title>
</head>
<body>
<div>
<h1>"I, insert name here, Thank Theo, For Teaching Me About Ec2s In Aws. One Step Closer To Escaping Dank!</h1>

<h1>With This Class, I Will Net ? Per Year!</h1>

<div class="tenor-gif-embed" data-postid="3349314281146682029" data-share-method="host" data-aspect-ratio="0.566265" data-width="20%"><a href="https://tenor.com/view/dank-demoss-falls-obesity-whale-falls-on-stage-gif-3349314281146682029">Dank Demoss Falls GIF</a>from <a href="https://tenor.com/search/dank+demoss-gifs">Dank Demoss GIFs</a></div> <script type="text/javascript" async src="https://tenor.com/embed.js"></script>

<h1>I'm bouncing sround from this fall still so forgive me</h1>

<h1>She is still trying to get up</h1>

<br>

<div class="tenor-gif-embed" data-postid="24170395" data-share-method="host" data-aspect-ratio="1.33333" data-width="20%"><a href="https://tenor.com/view/dank-memes-gif-24170395">Dank Memes GIF</a>from <a href="https://tenor.com/search/dank+memes-gifs">Dank Memes GIFs</a></div> <script type="text/javascript" async src="https://tenor.com/embed.js"></script>
<br>
<h2>Instance Details</h2>
    <p><strong>Hostname:</strong> ${HOST_NAME}</p>
    <p><strong>Private IP:</strong> ${LOCAL_IP}</p>
    <p><strong>Availability Zone:</strong> ${AZ}</p>
</body>
</html>