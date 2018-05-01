<%@ Page Title="" Language="C#" MasterPageFile="~/MyBlogMasterPage.master" AutoEventWireup="true"
    CodeFile="MyBlogCategory.aspx.cs" Inherits="MyBlogCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        /*定义两栏的栏目页MyBlogCategory.htm----------------------------开始--*/
        /*左边的主要内容*/
        #left-main-content
        {
            float: left;
            width: 628px; /*956-(316+2+5+2+3)=628*/
            background-color: #e6e8eb;
            height: 100%;
            border: 1px solid #72cfd7; /*画浅蓝色实线*/
        }
        /*右侧栏*/
        #right-sidebar
        {
            float: left;
            width: 316px; /*background-color: #e7f2fb; 背景色为淡蓝色,调试用，完成后最好删掉*/
            margin-left: 7px;
        }
        
        /*==用于MyBlogCategory.aspx,开始====*/
        /*分类博客列表区*/
        #MyBlog_list
        {
            width: 100%;
            background-color: #e7f2fb; /*背景色为淡蓝色,调试用，完成后最好删掉*/
        }
        /*博客列表区中的标题*/
        .MyBlog_list_title
        {
            font-size: 16px;
            font-family: 黑体, Helvetica, sans-serif;
            color: #000000;
            background-color: #EAF6FF;
            border: 1px solid #A2D8FF;
            text-align: center;
            height: 25px;
            padding-top: 8px;
        }
        /*博客列表区中的列表内容*/.MyBlog_list_content
        {
            color: #000000;
            font-family: 宋体, Helvetica, sans-serif;
            background-color: #FBFDFF;
            border: 1px solid #c3e0f5;
            line-height: 20px;
            text-align: left;
            padding: 10px;
        }
        /*博客列表区中的页码*/.MyBlog_list_page
        {
            line-height: 20px;
            text-align: center;
            height: 20px;
            border: 1px solid #c3e0f5;
        }
        /*==用于MyBlogCategory.aspx,结束====*/
        
        
        /*==用于MyBlogCategory.aspx,MyBlogShow.aspx中的最新博客。开始====*/
        
        /*最新博客块*/
        .new_MyBlog_box
        {
            width: 100%;
            margin-bottom: 10px; /*底边与footer的间距*/
        }
        /*最新博客标题*/
        .new_MyBlog_box .new_MyBlog_head
        {
            font-weight: bold;
            color: #83443B;
            background-color: #FFED9C;
            text-align: center;
            height: 15px;
            padding: 3px;
            border: 1px solid #FFD924;
        }
        /*最新博客内容*/
        .new_MyBlog_box .new_MyBlog_content
        {
            color: #000000;
            background-color: #FFFCEE;
            line-height: 20px;
            text-align: left;
            padding: 5px;
            border: 1px solid #FFD924;
        }
        /*==用于MyBlogCategory.aspx,MyBlogShow.aspx中的最新博客。结束====*/
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!--页面主体-开始-->
    <div id="left-main-content">
        <!--左侧主内容-开始-->
        <div id="MyBlog_list">
            <div class="MyBlog_list_title">
                博客列表
            </div>
            <div class="MyBlog_list_content">
            <table cellpadding="0" cellspacing="0" style="width: 96%;" border="0">
                <asp:Repeater ID="repMyBlogCategoryList" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td style="width: 375px;">
                                ·<a href="MyBlogShow.aspx?id=<%#Eval("MyBlogID") %>"><%#Eval("MyBlogTitle") %></a></td>
                            <td>
                                <%#Eval("CreatedDateTime","{0:g}") %>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
            </div>
            <div class="MyBlog_list_page">
            <asp:LinkButton ID="lbtnFirstPage" runat="server" OnClick="lbtnFirstPage_Click">首页</asp:LinkButton>
            <asp:LinkButton ID="lbtnpritPage" runat="server" OnClick="lbtnpritPage_Click">上一页</asp:LinkButton>
            <asp:LinkButton ID="lbtnNextPage" runat="server" OnClick="lbtnNextPage_Click">下一页</asp:LinkButton>
            <asp:LinkButton ID="lbtnDownPage" runat="server" OnClick="lbtnDownPage_Click">尾页</asp:LinkButton>
            第<asp:Label ID="lblPage" runat="server" Text="Label"></asp:Label>页/共<asp:Label ID="lblCountPage"
                runat="server" Text="Label"></asp:Label>页 共<asp:Label ID="lblTotal" runat="server" />条博客
            </div>
        </div>
        <!--左侧主内容-结束-->
    </div>
    <div id="right-sidebar">
        <!--右侧边栏-开始-->
        <div class="new_MyBlog_box">
            <div class="new_MyBlog_head">
                最新消息</div>
            <div class="new_MyBlog_content">
                <asp:Repeater ID="repNew" runat="server">
                    <ItemTemplate>
                        <a href="MyBlogShow.aspx?id=<%#Eval("MyBlogID") %>">·<%#Eval("MyBlogTitle").ToString().Trim().Length > 18 ? Eval("MyBlogTitle").ToString().Trim().Substring(0, 18) : Eval("MyBlogTitle").ToString().Trim()%></a><br />
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
        <div class="new_MyBlog_box">
            <div class="new_MyBlog_head">
                阅读排行</div>
            <div class="new_MyBlog_content">
                 <asp:Repeater ID="repSequence" runat="server">
                    <ItemTemplate>
                        <a href="MyBlogShow.aspx?id=<%#Eval("MyBlogID") %>">·<%#Eval("MyBlogTitle").ToString().Trim().Length > 18 ? Eval("MyBlogTitle").ToString().Trim().Substring(0, 18) : Eval("MyBlogTitle").ToString().Trim()%></a><br />
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
        <!--右侧边栏-结束-->
    </div>
    <!--页面主体-结束-->
</asp:Content>
