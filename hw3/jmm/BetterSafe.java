import java.util.concurrent.atomic.AtomicIntegerArray;

class BetterSafe implements State {
	private AtomicIntegerArray value;
	private byte maxval;

	BetterSafe(byte[] v) {
		int[] temp = new int[v.length];
		for (int i : temp)
			i = v[i];
		value = new AtomicIntegerArray(temp);
		maxval = 127;
	}

	BetterSafe(byte[] v, byte m) {
		int[] temp = new int[v.length];
        for (int i = 0 ; i < v.length; i++)
			temp[i] = v[i];
		value = new AtomicIntegerArray(temp);
		maxval = m;
	}

	public int size() { return value.length(); }

    public byte[] current() {
    	byte[] temp = new byte[value.length()];
    	for (int i = 0; i < value.length(); i++)
    		temp[i] = (byte) value.get(i);
    	return temp; 
 	}

    public boolean swap(int i, int j) {
		
		if (value.get(i) <= 0 || value.get(j) >= maxval) {
		    return false;
		}
		
		value.getAndDecrement(i);
		value.getAndIncrement(j);
		return true;
    }	

}