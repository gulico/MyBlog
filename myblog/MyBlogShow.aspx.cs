using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;//添加引用SQL Server;

public partial class MyBlogShow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        imgMyBlogPicture.Visible = false;//初始不显示博客图片
        if (Session["userFromHomeMyBlog"] == null)  //如果没有从HomeMyBlog.aspx登录，则定向到HomeMyBlog.aspx
        {
            Response.Redirect("HomeMyBlog.aspx"); //定向到HomeMyBlog.aspx
        }
        if (!Page.IsPostBack)
        {
            ShowNewMyBlogList();//显示“最新博客”名称列表
            ShowSequenceMyBlogList();//显示“阅读排行”列表 
            ShowMyBlog();//显示选定的博客内容
            ShowMyBlogAllUserReview();//显示选定博客的所有评论
        }
        if (Request.Cookies["username"] == null)  //如果用户没有登录,在UserLogin.asp.cs中保存
        {
            lbtnLogin.Visible = true;//显示“登录”按钮
            lbtnExit.Visible = false;//不显示“退出”按钮
            btnOK.Enabled = false;//“提交评论”按钮无效
        }
        else
        {
            lbtnLogin.Visible = false;//不显示“登录”按钮
            lbtnExit.Visible = true;//显示“退出”按钮
            btnOK.Enabled = true;//“提交评论”按钮有效
            lblUserName.Text = Request.Cookies["username"].Value;  //读取指定Cookie的值，赋给变量,显示已经登录的用户名
        }
    }
    private void ShowMyBlog()
    {   //显示详细博客内容
        string sqlStr = "select MyBlogID, MyBlogTitle, MyBlogAuthor, CreatedDateTime, MyBlogPicture, MyBlogContent, ShowPageCount from MyBlog where MyBlogID ='" + Request.QueryString["id"] + "'";
        SqlDataReader reader = SqlHelper.GetExecuteReader(sqlStr);
        string MyBlogPicture = "";
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                lblMyBlogTitle.Text = reader["MyBlogTitle"].ToString();//博客标题
                lblMyBlogAuthor.Text = reader["MyBlogAuthor"].ToString();//博客来源、作者
                MyBlogPicture = reader["MyBlogPicture"].ToString();//博客图片名
                if (MyBlogPicture != "temp.jpg".Trim()) //如果保存在表中的博客图片名称不是一个标识名称temp.jpg
                {
                    imgMyBlogPicture.ImageUrl = "~/Admin/UploadedImages/MyBlogPictures/" + MyBlogPicture;//博客图片的路径和名称
                    imgMyBlogPicture.Visible = true;//显示博客图片
                }
                lblMyBlogContent.Text = reader["MyBlogContent"].ToString();//博客内容
                lblCreatedDateTime.Text = reader["CreatedDateTime"].ToString();//发布时间
                lblShowPageCount.Text = reader["ShowPageCount"].ToString();//浏览次数
            }
        }
        reader.Close();//关闭读取器
        SqlHelper.CloseConnection();//关闭连接

        //浏览的网页数加1，单击数加1
        string sqlStr1 = "update MyBlog set ShowPageCount = ShowPageCount + 1 where MyBlogID =" + Request.QueryString["id"];
        SqlHelper.GetExecuteNonQuery(sqlStr1);
    }
    private void ShowNewMyBlogList()
    {   //显示“最新博客”名称列表
        string sqlStr = "select top 20 MyBlogID, MyBlogTitle from MyBlog where IsPass=1 order by CreatedDateTime desc";
        SqlDataReader reader = SqlHelper.GetExecuteReader(sqlStr);
        repNew.DataSource = reader;
        repNew.DataBind();
        reader.Close();//关闭读取器
        SqlHelper.CloseConnection();//关闭连接
    }
    private void ShowSequenceMyBlogList()
    {  //显示“阅读排行”列表  
        string sqlStr = "select top 20 MyBlogID, MyBlogTitle from MyBlog where IsPass=1 order by CreatedDateTime ";
        SqlDataReader reader = SqlHelper.GetExecuteReader(sqlStr);
        repSequence.DataSource = reader;
        repSequence.DataBind();
        reader.Close();//关闭读取器
        SqlHelper.CloseConnection();//关闭连接
    }
    private void ShowMyBlogAllUserReview()
    {   //显示博客的所有用户评论

        //计算该博客（MyBlogID）的评论条数
        string sqlStr1 = "select count(*) from UserReview where MyBlogID =" + Request.QueryString["id"];
        lblReviewCount.Text = SqlHelper.GetExecuteScalar(sqlStr1).ToString();

        //列出该博客（MyBlogID）的所有评论，显示次序是：先显示最后的评论
        string sqlStr = "select UserID, UserName, UserReviewContent, MyBlogID, CreatedDateTime, LoginIP from UserReview where MyBlogID =" + Request.QueryString["id"] + " order by UserReviewID desc";
        SqlDataReader reader = SqlHelper.GetExecuteReader(sqlStr);
        repReviewList.DataSource = reader;
        repReviewList.DataBind();
        reader.Close();//关闭读取器
        SqlHelper.CloseConnection();//关闭连接
    }
    protected void btnOK_Click(object sender, EventArgs e)
    {
        //"提交评论"按钮
        int userID = Convert.ToInt32(Request.Cookies["userid"].Value);  //读取指定Cookie的值
        string userName = Request.Cookies["username"].Value;  //读取指定Cookie的值
        string userReviewContent = txtUserReviewContent.Text.Trim();
        int MyBlogID = int.Parse(Request.QueryString["id"]);
        DateTime createdDateTime = DateTime.Now;//系统时间
        string loginIP = Request.UserHostAddress.ToString();//IP

        if (userReviewContent != null) //如果写有评论
        {
            if (AddReview(userID, userName, userReviewContent, MyBlogID, createdDateTime, loginIP) > 0) //添加评论
            {
                Response.Redirect("MyBlogShow.aspx?id=" + Request.QueryString["id"]);
            }
        }
        else
        {
            Response.Write("<script>alert('请输入评论内容!');history.go(-1);</script>");
        }
    }
    private int AddReview(int userID, string userName, string userReviewContent, int MyBlogID, DateTime createdDateTime, string loginIP)
    {
        //添加评论
        string sqlStr = "insert into UserReview(UserID, UserName, UserReviewContent, MyBlogID, CreatedDateTime, LoginIP)" + "Values('" + userID + "','" + userName + "','" + userReviewContent + "','" + MyBlogID + "','" + createdDateTime + "','" + loginIP + "')";
        int i = SqlHelper.GetExecuteNonQuery(sqlStr);
        return i;
    }
    protected void lbtnExit_Click(object sender, EventArgs e)
    {
        //"退出"登录按钮
        if (Request.Cookies["username"] != null)
        {
            Response.Cookies["username"].Expires = DateTime.Now.AddDays(-1);//Cookie有效期过期
            Response.Redirect("MyBlogShow.aspx?id=" + Request.QueryString["id"]);
        }
    }
    protected void lbtnLogin_Click(object sender, EventArgs e)
    {
        //"登录"按钮
        string linkStr = "UserLogin.aspx";//去登录页面
        Response.Redirect(linkStr);
    }
}