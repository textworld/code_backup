<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="rxy.data.*" %>
<%@ page import="rxy.javabean.*" %>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="public/js/calendar.js"></script>
    <script type="text/javascript">
    	<% if(((UserBean)session.getAttribute("user")).getType() == 0){ %>
    	<%
    		List<Integer> list = GetFeverDay.getFeverDay(((UserBean)session.getAttribute("user")).getId());
    	%>
    	
    	<% if(list != null && list.size() != 0) { %>
    		var fever = [ <%for(int i = 0; i < list.size(); i++){ out.print(list.get(i) + ",");} %>];
    	<% }else{ %>
    	var fever = [];
    	<% } %>
    	<% }else{ %>
    	var fever = [];
    	<% } %>
    	function in_array(arr, iterm){
    		for(var i in arr){
    			if(arr[i] == iterm){
					return true;    			
    			}
    		}
    		return false;
    	}
    	if(document.getElementById('rxy-calendar')){
	    	var cal = new Calendar(
	    		{
	    			element: "rxy-calendar",
	    			tdCallback : function(x){
	    				var td = document.createElement("td");
	    				if(x == 0){
	    					x = "";
	    				}
	    				var txtNode = document.createTextNode(x);
	    				td.appendChild(txtNode);
	    				if(in_array(fever, x)){
	    					td.className = "cal-fever";
	    				}
	    				if(x == this.day){
	    					td.className =  " cal-today";
	    				}
	    				td.appendChild(txtNode);
	    				return td;
	    			}
	    		});
			cal.init();
    	}
	</script>
</body>
</html>
