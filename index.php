<html>
<head>
<title>Page on PHP</title>
</head>
<body>
<h1>Example using PHP</h1>
<p>This page shows your current IP address and current server time.</p>
<p>Your IP address: <?php echo $_SERVER['REMOTE_ADDR']; ?></p>
<p>Current date and time: <?php echo date('d.m.Y H:i:s'); ?></p>
</body>
</html>
