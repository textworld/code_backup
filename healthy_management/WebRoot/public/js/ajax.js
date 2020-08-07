(function(global){
	var AjaxData = function(date, option){
		if(date){
			this.date = date;
		}else{
			this.date = new Date();
		}
		this.year = this.date.getFullYear();
		this.month = this.date.getMonth() + 1;
		this.day = this.date.getDate();
		this.daysOfMonth = -1;
		this.url = "";
		if(option){
			this.option = option;
		}
	};
	
	AjaxData.prototype.getYesterday = function(callback){
		this.backToYesterday();
		$.ajax({url : this.url, success: callback, dataType: "json"});
	};
	
	AjaxData.prototype.getDataDaysBefore = function(num, callback, errcallback){
		while(num < 0)
		{
			this.backToYesterday();
			num = num + 1;
		}
		console.log("begin to ajax " + this.url);
		$.ajax({url : this.url, success: callback, dataType: "json", error: errcallback});
		console.log("end to ajax " + this.url);
	};
	
	AjaxData.prototype.getUrl = function(){
		if(this.option && this.option.child_id && this.option.type){
			this.url =  "http://localhost:8080/healthy_management/api/ajax?year=" +
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
	
	AjaxData.prototype.backToYesterday = function(){
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
		this.getUrl();
	}
	AjaxData.prototype.getDaysOfMonth = function(year, month){
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
	}
	global.AjaxData = AjaxData;
})(window);