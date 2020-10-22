$EmailTo = "pruebasdemo@gmail.com"
$EmailFrom = "pruebasdemo@gmail.com"
$Subject = "BACKUP SERVER Pau FINISH"
$Body = "Finish backup script."
$SMTPServer = "servidorsmtp"
#$filenameAndPath = "E:\BACKUP_SERVIDOR\log_.txt"
$SMTPMessage = New-Object System.Net.Mail.MailMessage($EmailFrom,$EmailTo,$Subject,$Body)
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 
#$attachment = New-Object System.Net.Mail.Attachment($filenameAndPath)
#$SMTPMessage.Attachments.Add($attachment)
$SMTPClient.EnableSsl = $true 
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("pruebasdemo@gmail.com","passworddelmail"); 
$SMTPClient.Send($SMTPMessage)
