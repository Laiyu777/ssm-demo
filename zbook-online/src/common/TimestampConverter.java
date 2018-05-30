package common;

import java.sql.Timestamp;

import org.springframework.core.convert.converter.Converter;

public class TimestampConverter implements Converter<String,Timestamp>{

	@Override
	public Timestamp convert(String arg0) {
		if(arg0.trim().length()!=0 && arg0!=null){
			Timestamp timestamp = Timestamp.valueOf(arg0);
			return timestamp;
		}
		return null;
	}
	

}
