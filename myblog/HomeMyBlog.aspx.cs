using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;//添加引用SQL Server;

public partial class HomeMyBlog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Session["userFromHomeMyBlog"] = 1;//判断从HomeMyBlog.aspx执行

            ShowChinaMyBlogList();//显示“时事”列表，博客类别为1
            ShowFinanceMyBlogList();//显示“财经”博客列表，博客类别为3
            ShowHealthMyBlogList();//显示“健康”博客列表，博客类别为5
            ShowForeignMyBlogList();//显示“体育”列表，博客类别为2
            ShowPastimeMyBlogList();//显示“娱乐”博客列表，博客类别为4
            ShowNatureMyBlogList();//显示“旅游”博客列表，博客类别为6
            ShowNewMyBlogList();//显示“最新发布”列表
            ShowSequenceMyBlogList();//显示“阅读排行”列表  
            ShowFriendLink();//显示友情链接
        }
    }
    private void ShowChinaMyBlogList()
    {   //显示“时事”列表，时事类别为1，显示8行
        string sqlStr = "select top 8 MyBlogID, MyBlogTitle from MyBlog where IsPass=1 and MyBlogCategoryID=1 order by CreatedDateTime desc";//按时间倒序显示最新发布的8条博客
        SqlDataReader reader = SqlHelper.GetExecuteReader(sqlStr);
        repChina.DataSource = reader;//数据源设置到repChina
        repChina.DataBind();//绑定到repChina
        reader.Close();//关闭读取器
        SqlHelper.CloseConnection();//关闭连接
    }
    private void ShowFinanceMyBlogList()
    {   //显示“财经”博客列表，博客类别为3
        string sqlStr = "select top 8 MyBlogID, MyBlogTitle from MyBlog where IsPass=1 and MyBlogCategoryID=3 order by CreatedDateTime desc";
        SqlDataReader reader = SqlHelper.GetExecuteReader(sqlStr);
        repFinance.DataSource = reader;
        repFinance.DataBind();
        reader.Close();//关闭读取器
        SqlHelper.CloseConnection();//关闭连接
    }
    private void ShowHealthMyBlogList()
    {   //显示“健康”博客列表，博客类别为5
        string sqlStr = "select top 8 MyBlogID, MyBlogTitle from MyBlog where IsPass=1 and MyBlogCategoryID=5 order by CreatedDateTime desc";
        SqlDataReader reader = SqlHelper.GetExecuteReader(sqlStr);
        repHealth.DataSource = reader;
        repHealth.DataBind();
        reader.Close();//关闭读取器
        SqlHelper.CloseConnection();//关闭连接
    }
    private void ShowForeignMyBlogList()
    {   //显示“体育”列表，博客类别为2
        string sqlStr = "select top 8 MyBlogID, MyBlogTitle from MyBlog where IsPass=1 and MyBlogCategoryID=2 order by CreatedDateTime desc";
        SqlDataReader reader = SqlHelper.GetExecuteReader(sqlStr);
        repForeign.DataSource = reader;
        repForeign.DataBind();
        reader.Close();//关闭读取器
        SqlHelper.CloseConnection();//关闭连接
    }
    private void ShowPastimeMyBlogList()
    {   //显示“娱乐”博客列表，博客类别为4
        string sqlStr = "select top 8 MyBlogID, MyBlogTitle from MyBlog where IsPass=1 and MyBlogCategoryID=4 order by CreatedDateTime desc";
        SqlDataReader reader = SqlHelper.GetExecuteReader(sqlStr);
        repPastime.DataSource = reader;
        repPastime.DataBind();
        reader.Close();//关闭读取器
        SqlHelper.CloseConnection();//关闭连接
    }
    private void ShowNatureMyBlogList()
    {   //显示“旅游”博客列表，博客类别为6
        string sqlStr = "select top 8 MyBlogID, MyBlogTitle from MyBlog where IsPass=1 and MyBlogCategoryID=6 order by CreatedDateTime desc";
        SqlDataReader reader = SqlHelper.GetExecuteReader(sqlStr);
        repNature.DataSource = reader;
        repNature.DataBind();
        reader.Close();//关闭读取器
        SqlHelper.CloseConnection();//关闭连接
    }

    private void ShowNewMyBlogList()
    {  //显示“最新发布”列表
        string sqlStr = "select top 10 MyBlogID, MyBlogTitle from MyBlog where IsPass=1 order by CreatedDateTime desc";
        SqlDataReader reader = SqlHelper.GetExecuteReader(sqlStr);
        repNew.DataSource = reader;
        repNew.DataBind();
        reader.Close();//关闭读取器
        SqlHelper.CloseConnection();//关闭连接
    }
    private void ShowSequenceMyBlogList()
    {  //显示“阅读排行”列表  
        string sqlStr = "select top 9 MyBlogID, MyBlogTitle ,ShowPageCount from MyBlog where IsPass=1 order by ShowPageCount desc";
        SqlDataReader reader = SqlHelper.GetExecuteReader(sqlStr);
        repSequence.DataSource = reader;
        repSequence.DataBind();
        reader.Close();//关闭读取器
        SqlHelper.CloseConnection();//关闭连接
    }
    private void ShowFriendLink()
    {
        //显示友情链接
        string sqlStr = "select top 3 FriendLinkName,FriendLinkUrl,LogoPath from FriendLink where IsShow=1 order by FriendLinkSort";//显示4个友情链接图片
        SqlDataReader reader = SqlHelper.GetExecuteReader(sqlStr);
        repFriendLink.DataSource = reader;
        repFriendLink.DataBind();
        reader.Close();//关闭读取器
        SqlHelper.CloseConnection();//关闭连接
    }
}