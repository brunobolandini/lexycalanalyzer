package lua;

public class LuaToken {

    public String name;
    public String value;
    public int line;
    public int column;

    public LuaToken(String name, String value, int line, int column) {
        this.name = name;
        this.value = value;
        this.line = line;
        this.column = column;
    }
}