<%@ WebHandler Language="C#" Class="image" %>
 
using System;
using System.Web;
using System.Drawing;
using System.Drawing.Imaging;
using System.Web.UI.WebControls;

using System.Collections.Generic;
using System.Web.UI;
using System.Net.Mail;
using System.IO;

public class image : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        Bitmap bmp = new Bitmap(1, 1);
        Graphics graphics = Graphics.FromImage(bmp);

        int width = (int)Math.Ceiling(1.0);
        int height = (int)Math.Ceiling(1.0);

        bmp = new Bitmap(bmp, width, height);
        graphics.Dispose();
        graphics = Graphics.FromImage(bmp);
        graphics.Clear(Color.White);

        graphics.Dispose();
        bmp.Save(context.Response.OutputStream, ImageFormat.Gif);

        string ip_address = "";
        if (string.IsNullOrEmpty(HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"]))
        {
            ip_address = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }
        else
        {
            ip_address = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].Split(",".ToCharArray(), StringSplitOptions.RemoveEmptyEntries)[0];
        }

        using (System.IO.StreamWriter writer = new System.IO.StreamWriter(context.Server.MapPath("IPAddress.txt"), true))
        {
            writer.WriteLine(ip_address);
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
 
}