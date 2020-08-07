
(function(global){
	function createElement(name){
		return global.document.createElement(name);
	}
	
	function getDocument(){
		return global.document;
	}
	var Calendar = function(option){
		this.date = new Date();
		this.year = this.date.getFullYear();
		this.month = this.date.getMonth();
		this.day = this.date.getDate();
		this.hour = this.date.getHours();
		this.minute = this.date.getMinutes();
		this.second = this.date.getSeconds();
		this.millSecond = this.date.getMilliseconds();
		this.arrofmonth = [];
		this.arrofweek = ["一", "二", "三", "四", "五", "六", "日"];
		
		if(option && option.element && typeof option.element == "string"){
			this.element = option.element;
		}
		
		if(option && option.tdCallback && typeof option.tdCallback == "function"){
			this.callback = option.tdCallback;
		}
	};
	Calendar.prototype.set = function(field, value){
		switch(field.toLowerCase()){
		case "year":
			this.year = value;
			break;
		case "month":
			this.month = value;
			break;
		case "day":
			this.day = value;
			break;
		case "hour":
			this.hour = value;
			break;
		case "minute":
			this.minute = value;
			break;
		case "second":
			this.second = value;
			break;
		case "millSecond":
			this.millSecond = value;
		default:
			break;
		}
		Calendar.getDaysOfMonth();
	};
	
	Calendar.prototype.getDaysOfMonth = function(){
		if((this.year % 100  == 0 && this.year % 400 == 0) || this.year % 4 == 0){
			this.leapYear = 1;
		}else{
			this.leapYear = 0;
		}
		if(this.month == 2){
			if(this.leapYear == 1){
				this.daysOfMonth = 29;
			}else{
				this.daysOfMonth = 28;
			}
		}else{
			switch((this.month+1)){
			case 1:
			case 3:
			case 5:
			case 7:
			case 8:
			case 10:
			case 12:
				this.daysOfMonth = 31;
				break;
			default:
				this.daysOfMonth = 30;
				break
			
			};
		}
	};
	Calendar.prototype.setArr = function(){
		for(var i = 0; i < 41; i++){
			this.arrofmonth[i] = 0;
		}
		var d = new Date();
		d.setYear(this.year);
		d.setMonth(this.month);
		d.setDate(1);
		var day = d.getDay() - 1;
		var index = (day == -1 ? 6 : day);
		this.index = index;
		for(i = index, j = 1; i < index + this.daysOfMonth; i++){
			this.arrofmonth[i] = j++;
		}
	};
	
	Calendar.prototype.init = function(){
		this.getDaysOfMonth();
		this.setArr();
		if(!this.element){
			console.log("Calendar: an element is needed!");
			return;
		}
		this.element = getDocument().getElementById(this.element);
		if(!this.element){
			console.log("Calendar: the element is not found!");
		}
		this.showYM();
		this.putElement();
	};
	// show year and month
	Calendar.prototype.showYM = function(){
		var p = createElement("p");
		p.className = "cal-ym";
		var txt = getDocument().createTextNode((this.year) + "年" + " " + (this.month + 1) + "月");
		p.appendChild(txt);
		this.element.appendChild(p);
	};
	Calendar.prototype.putElement = function(){
		var table = createElement("table");
		table.className = "table table-bordered";
		var thead = createElement("thead");
		var tr = createElement("tr");
		
		for(var i = 0; i < 7; i++){
			var td = createElement("td");
			var txt = getDocument().createTextNode(this.arrofweek[i]);
			td.appendChild(txt);
			tr.appendChild(td);
		}
		thead.appendChild(tr);
		table.appendChild(thead);
		var tbody = createElement("tbody");
		var trs = [];
		var trs_num;
		if(this.index < 5){
			trs_num = 5;
		}else{
			trs_num = 6;
		}
		for(i = 0; i < 6; i++){
			trs[i] = createElement("tr");
		}
		for(i = 0; i < 41; i++){
			var td = createElement("td");
			if(this.callback){
				td = this.callback(this.arrofmonth[i]);
			}else{
				var node_txt;
				if(this.arrofmonth[i] == 0){
					node_txt = "";
				}else{
					node_txt = this.arrofmonth[i];
				}
				var  txt = getDocument().createTextNode(node_txt);
				td.appendChild(txt);
				if(node_txt == this.day){
					td.className = "cal-today";
				}
			}
			
			trs[parseInt(i/7)].appendChild(td);
		}
		for(i=0; i < trs_num; i++){
			tbody.appendChild(trs[i]);
		}
		table.appendChild(tbody);
		this.element.appendChild(table);
	};
	
	
	global.Calendar = Calendar;
})(this);


