using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;//添加引用SQL Server;
using System.Data;//添加对DataSet的引用

public partial class MyBlogMasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            MyBlogCategoryMenu();//显示博客导航栏
        }    
    }
    private void MyBlogCategoryMenu()
    {
        //显示博客导航栏
        string sqlStr = "select MyBlogCategoryID, MyBlogCategoryName from MyBlogCategory order by MyBlogCategorySort asc";
        SqlDataReader reader = SqlHelper.GetExecuteReader(sqlStr);
        repMyBlogCategory.DataSource = reader;
        repMyBlogCategory.DataBind();
        reader.Close();//关闭读取器
        SqlHelper.CloseConnection();//关闭连接
    }
}
