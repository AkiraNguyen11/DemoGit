package poly.com.service;

public interface SessionServiceIn {
	<T> T get(String name);
	
	<T> T getValue(String name, T defaultValue);

	void set(String name, Object value);

	void remove(String name);
}
