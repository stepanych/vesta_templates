#drupal 7
<VirtualHost %ip%:%web_port%>

    ServerName %domain_idn%
    %alias_string%
    ServerAdmin %email%
    DocumentRoot %docroot%
    ScriptAlias /cgi-bin/ %home%/%user%/web/%domain%/cgi-bin/
    Alias /vstats/ %home%/%user%/web/%domain%/stats/
    Alias /error/ %home%/%user%/web/%domain%/document_errors/
    #SuexecUserGroup %user% %group%
    CustomLog /var/log/%web_system%/domains/%domain%.bytes bytes
    CustomLog /var/log/%web_system%/domains/%domain%.log combined
    ErrorLog /var/log/%web_system%/domains/%domain%.error.log
    <Directory %docroot%>
        RewriteEngine on
        RewriteBase /
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteCond %{REQUEST_URI} !=/favicon.ico
        RewriteRule ^ index.php [L]
        AllowOverride All
        Options +Includes -Indexes +ExecCGI
    </Directory>
    <Directory %home%/%user%/web/%domain%/stats>
    AllowOverride All
    </Directory>

    <IfModule mod_ruid2.c>
        RMode config
        RUidGid %user% %group%
        RGroups www-data
    </IfModule>
    <IfModule itk.c>
        AssignUserID %user% %group%
    </IfModule>

    IncludeOptional %home%/%user%/conf/web/%web_system%.%domain%.conf*

</VirtualHost>