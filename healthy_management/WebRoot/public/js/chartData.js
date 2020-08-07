(function(global){

	var Chart = function(e, option){
		if(e){
			this.element = e;
		}else{
			this.element = "chart";
		}
		if(option){
			this.option = option;
		}else{
			this.option = {};
		}
		this.date = new Date();
		this.year = 2015;
		this.month = 1;
		this.day = 1;
		this.url = "";
		this.index = 0;
		this.data = null;
	};
	
	Chart.prototype.initTime = function(){
		this.year = this.date.getFullYear();
		this.month = this.date.getMonth() + 1;
		this.day = this.date.getDate();
	};
	Chart.prototype.init = function(){
		this.node = global.document.getElementById(this.element);
		if(!this.node){
			console.log("element \"" + this.element + "\": not found");
			return;
		}
		this.initTime();
		this.getDataIndex(0);
	};
	Chart.prototype.getDataIndex = function(index){
		this.initTime();
		while(index != 0){
			if(index < 0){
				this.backToYesterday();
				index = index + 1;
			}else{
				index = index - 1;
			}			
		}
		$(this.node).html("<p>正在加载中...</p>");
		this.getData();
	}
	
	Chart.prototype.handlerData = function(t){
		if(t.data && t.data.data){
			if(t.data.type == 1){
				t.Chart_Line_Temp(t.element, t.data.data);
			}else if(t.data.type == 2){
				t.Chart_Line_Heart(t.element, t.data.data);
			}else if(t.data.type == 3){
				t.Chart_Line_Sleep(t.element, t.data.data);
			}
		}else{
			console.log("null data");
			$(t.node).html("<p>暂无数据</p>");
		}
	};
	
	Chart.prototype.getData = function(){
		this.getUrl();
		var t = this;
		$.ajax({url : this.url, dataType: "json", success: function(data){
			if(data && data.status && data.status == -1){
				$(t.node).html("暂无数据");
				return;
			}
			for(var i = 0; i < data.data.length; i ++){
				data.data[i].time = data.data[i].time * 1000;
			}
			t.data = data;
			t.handlerData(t);
		}, error: function(){
			$(t.node).html("<p>加载失败</p>");
		}});
		
	};
	
	
	
	Chart.prototype.getUrl = function(){
		if(this.option && this.option.child_id && this.option.type){
			var url_api;
			if(this.option.week && this.option.week == 1){
				url_api = "GetDataOneWeek"
			}else{
				url_api = "ajax";
			}
			this.url =  "http://localhost:8080/healthy_management/api/" + url_api + "?year=" +
					this.year + "&month=" +
					this.month +"&day="+
					this.day +"&child_id="+
					this.option.child_id+"&type=" +
					this.option.type;
			console.log("ajax url: " + this.url);
		}else{
			console.log("url is not defined");
		}
	};
	
	Chart.prototype.backToYesterday = function(){
		if(this.day != 1){
			this.day -= 1;
		}else{
			if(this.month != 1){
				daysOfMonth = this.getDaysOfMonth(this.year, this.month - 1);
				this.month -= 1;
				this.day = daysOfMonth;
			}else{
				this.year -= 1;
				this.day = 31;
			}
		}
	}
	
	Chart.prototype.getDaysOfMonth = function(){
		if(month != 2){
			switch(this.month){
			case 1:
			case 3:
			case 5:
			case 7:
			case 8:
			case 10:
			case 12:
				daysOfMonth = 31;
				break
			default:
				daysOfMonth = 30;
			}
		}else{
			if(year % 100 == 0 && year % 400 == 0 || year % 4 == 0){
				daysOfMonth = 29;
			}else{
				daysOfMonth = 28;
			}
		}
		return daysOfMonth;
	};
	
	Chart.prototype.callback = function(data){
		if(data && data.data){
			for(var i = 0; i < data.data.length; i++)
			{
				data.data[i].time = data.data[i].time * 1000;
			}
			if(data.type == 1){
				Chart_Line(element, data.data);
			}
		}else{
			$(this.element).html("暂无数据");
		}
	};
	
	Chart.prototype.errcallback = function(res, err){
		alert("Ajax 过程发生错误");
	};
	Chart.prototype.Chart_Line_Temp = function(e, data){
		console.log("begin to line");
        var element = global.document.getElementById(e);
        $(element).html(" ");
        console.log("data:");
        console.log(data);
		Morris.Line({
			element: e,
			data: data, 
			xkey: 'time',
    			ykeys: ['data'],
    			labels: ['体温'],
    			pointSize: 3,
    			hideHover: false,
    			resize: true,
    			lineColors: function(row, sidx, type){
    				if(type == "line"){
    					return "#0b62a4";
    				}else if(type == "point"){
    					if(row && row.src.data > 37.5){
    						return "#ff0000";
    					}else{
    						return "#0b62a4"; 
    					}
    				}
    			},
    			ymax: 42,
    			ymin: 35,
    			goals: [37.5],
    			goalStrokeWidth: 1.5,
    			dateFormat: function(x){
    				var tt_date = new Date(x);
    				var month = tt_date.getMonth() + 1;
    				return month + "月" + tt_date.getDate() + "日 " + tt_date.getHours() + "点" + tt_date.getMinutes() + "分";
    			},
    			goalArea: [37.5, 42]
		});
	};
	
	Chart.prototype.Chart_Line_Heart = function(e, data){
		console.log("begin to line");
        var element = global.document.getElementById(e);
        $(element).html("");
        console.log("data:");
        console.log(data);
        Morris.Line({
			element: e,
			data:data, 
			xkey: 'time',
    			ykeys: ['data'],
    			labels: ['心跳'],
    			pointSize: 2,
    			hideHover: false,
    			resize: true,
    			ymax: 200,
     			ymin: 40,
    			goals: [80],
    			lineColors: ['#d55731'],
    			dateFormat: function(x){
    				var tt_date = new Date(x);
    				var month = tt_date.getMonth() + 1;
    				return month + "月" + tt_date.getDate() + "日 " + tt_date.getHours() + "点" + tt_date.getMinutes() + "分";
    			}
        });
	};
	
	Chart.prototype.Chart_Line_Sleep = function(e, data){
		var element = global.document.getElementById(e);
        $(element).html("");
        var formatDate = function(x){
        	console.log(x);
			var tt_date = new Date(x);
			var month = tt_date.getMonth() + 1;
			return month + "月" + tt_date.getDate() + "日 ";
        };
        for(var i = 0; i < data.length; i++){
        	data[i].time = formatDate(data[i].time);
        }
		Morris.Bar({
			element: e,
			data: data, 
			xkey: 'time',
			ykeys: ['data'],
			labels: ['睡眠时间'],
			pointSize: 2,
			hideHover: false,
			resize: true,
			ymax: 13,
			ymin: 4,
			dateFormat: function(x){
				
			}
		});
	};
	global.Chart = Chart;
})(window);