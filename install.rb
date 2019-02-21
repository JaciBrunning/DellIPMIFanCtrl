service = <<EOF
[Unit]
Description=Curtin FRC Vision Service

[Service]
Type=simple
Restart=always
ExecStart=ruby fanctrl.rb
WorkingDirectory=#{File.absolute_path File.dirname(__FILE__)}

[Install]
WantedBy=multi-user.target

EOF

File.write("/etc/systemd/system/fanctrl.vision", service)
`systemctl daemon-reload`
`service fanctrl restart`
sleep 2
`service fanctrl status`