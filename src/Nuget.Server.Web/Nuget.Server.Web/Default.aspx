<%@ Page Language="C#" %>
<%@ Import Namespace="NuGet.Server" %>
<%@ Import Namespace="NuGet.Server.App_Start" %>
<%@ Import Namespace="NuGet.Server.Infrastructure" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ARC NuGet Hub</title>
    <style>
        body { font-family: Calibri; }
    </style>
</head>
<body>
    <div>
        <h2>欢迎来到 ARC Nuget Hub v<%= typeof(NuGetODataConfig).Assembly.GetName().Version %></h2>
        <p>
            点击 <a href="<%= VirtualPathUtility.ToAbsolute("~/nuget/Packages") %>">这里</a> 查看nuget信息。
        </p>
        <fieldset style="width:800px">
            <legend><strong>Repository URLs</strong></legend>
            在nuget包管理设置中，将下面的地址添加到包源。
            <blockquote>
                <strong><%= Helpers.GetRepositoryUrl(Request.Url, Request.ApplicationPath) %></strong>
            </blockquote>
            去往 <a href="https://www.nuget.org/downloads">NuGet command line tool</a> (nuget.exe)下载NuGet tool，使用下面命令将nuget包推送到服务.
            <blockquote>
                <strong>nuget.exe push {package file} {apikey} -Source <%= Helpers.GetPushUrl(Request.Url, Request.ApplicationPath) %></strong>
            </blockquote>
        </fieldset>

        <% if (Request.IsLocal || ServiceResolver.Current.Resolve<NuGet.Server.Core.Infrastructure.ISettingsProvider>().GetBoolSetting("allowRemoteCacheManagement", false)) { %>
        <fieldset style="width:800px">
            <legend><strong>添加 nuget packages</strong></legend>

            上传nuget包到Azure共享存储 nuget share，

            点击 <a href="<%= VirtualPathUtility.ToAbsolute("~/nuget/clear-cache") %>">这里</a> 清除缓存。
        </fieldset>
        <% } %>
    </div>
</body>
</html>
