	function cutName(name, item) {
		if(item == 3){
			name = name.substring(0,11);
		}else if(item == 4){
			name = name.substring(0,8);
		}else if(item == 5){
			name = name.substring(0,11);
		}
		return name;
	}
	
	function formactDirection(value){
		var chng = value;
		var strVal = "su";
		
		if (chng.charAt(0) == '-')
			strVal = "giu";
		else
			strVal = "su";
			
		return strVal;
	}
	
	//time format from [0-24] to [0-12] (without AM / PM )
	function formatTime(val) {
		var a = new Number(val.substring(0,val.indexOf(":")));
		if (a > 12) {
			a -= 12;
		}
		var b = val.substring(val.indexOf(":"),val.length);
		return a + b;
	}
	
	//format a decimal number to a fixed number of decimals 
	function formatDecimal(value, decimals, keepZero) {
		var mul = new String("1");
		var zero = new String("0");
		for (var i = decimals; i > 0; i--) {
			mul += zero;
		}
		value = Math.round(value * mul);
		value = value / mul;
		var strVal = new String(value);
		if (!keepZero) {
			return strVal;	
		}
		
		var nowDecimals = 0;
		var dot = strVal.indexOf(".");
		if (dot == -1) {
			strVal += ".";
		} else {
		 	nowDecimals = strVal.length - dot - 1;
		}
		for (var i = nowDecimals; i < decimals; i++) {
			strVal = strVal + zero;
		}
			
		return strVal;
	}