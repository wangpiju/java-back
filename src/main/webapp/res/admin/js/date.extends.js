Date.prototype.format = function(format) {  
    /* 
     * eg:format="yyyy-MM-dd hh:mm:ss"; 
     */  
    var o = {  
        "M+" : this.getMonth() + 1, // month  
        "d+" : this.getDate(), // day  
        "h+" : this.getHours(), // hour  
        "m+" : this.getMinutes(), // minute  
        "s+" : this.getSeconds(), // second  
        "q+" : Math.floor((this.getMonth() + 3) / 3), // quarter  
        "S" : this.getMilliseconds()  
        // millisecond  
    }  
  
    if (/(y+)/.test(format)) {  
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4  
                        - RegExp.$1.length));  
    }  
  
    for (var k in o) {  
        if (new RegExp("(" + k + ")").test(format)) {  
            format = format.replace(RegExp.$1, RegExp.$1.length == 1  
                            ? o[k]  
                            : ("00" + o[k]).substr(("" + o[k]).length));  
        }  
    }  
    return format;  
}

/**
 * 获取日期，可以设置前后天数
 * @returns {Date}
 */
Date.prototype.addHour = function(n,format){
	if((typeof n) != "number") n=0;
	var d = this.clone();
	d.setHours(d.getHours()+n);
	
	if((typeof format) == "string")
		return d.format(format);
	else
		return d;
}

/**
 * 获取日期，可以设置前后天数
 * @returns {Date}
 */
Date.prototype.addDay = function(n,format){
	if((typeof n) != "number") n=0;
	var d = this.clone();
	d.setDate(d.getDate()+n);
	
	if((typeof format) == "string")
		return d.format(format);
	else
		return d;
}


/**
 * 月添加
 * @param format 格式
 * @param da 提前月数
 * @returns
 */
Date.prototype.addMonth = function(n,format){
	var d = this.clone();
	if((typeof n) != "number") n=0;
	
	d.setMonth(d.getMonth()+n);
	if((typeof format) == "string")
		return d.format(format);
	else
		return d;
}

/**
 * 周开始的日期（星期1）
 * @param format 格式
 * @param da 前面周数
 * @returns
 */
Date.prototype.getWeekStart = function(n,format){
	if((typeof n) != "number") n = 0;
	var d = this.clone();
	if(n!=0){
		if(n>0){
			for(var i=0;i<n;i++){
				d = d.addDay(7);
			}
		}
		else{
			for(var i=0;i>n;i--){
				d = d.addDay(-7);
			}
		}
	}
	d = d.addDay(1 - d.getDay());
	
	if((typeof format) == "string")
		return d.format(format);
	else
		return d;
}

Date.prototype.clone = function(){
	return new Date(this.getTime());
}
