package cases;
import BaseTestCase;
import cases.sample.Sample.SampleAbstract;
import cases.sample.Sample.SampleClass;
import cases.sample.Sample.SampleEnum;
import haxe.ds.Vector;
import typepacker.json.Json;
import typepacker.json.JsonPacker;

/**
 * ...
 * @author shohei909
 */
class JsonPackerTestCase extends BaseTestCase
{

    public function new()
    {
        super();
    }

    public function testPrint() {
        assertEquals("1.1", Json.print("Float", 1.1));
        assertEquals("1", Json.print("Float", 1));
        assertEquals("\"サンプル入力\"", Json.print("String", "サンプル入力"));
        assertEquals("null", Json.print("Empty", null));
        assertEquals("{}", Json.print("Empty", { } ));
        assertEquals("[null,{}]", Json.print("ArrayEmpty", [null, { } ]));
        assertEquals("{\"i\":-12}", Json.print("IntData", { i : -12 } ));
        assertEquals("{\"i\":50}", Json.print("IntData", new SampleClass()));
        assertEquals("[\"NONE\"]", Json.print("cases.sample.Sample.SampleAbstract", new SampleAbstract(SampleEnum.NONE)));
    }

    public function testParse() {
        assertEquals(1, Json.parse("Int", "1"));
        assertEquals(1.0, Json.parse("Float", "1"));
        assertEquals(-2.1, Json.parse("Float", "-2.1"));
        assertEquals("\"", Json.parse("String", "\"\\\"\""));
        assertEquals(null, Json.parse("Empty", "null"));

        assertTrue(Std.is(Json.parse("List<Int>", "[5]"), List));
        // assertEquals("5", Json.parse(StringVector, '["5"]')[0]);

        var cl = Json.parse("SampleClass", "{\"i\":50}");
        assertTrue(Std.is(cl, SampleClass));
        assertEquals(50, cl.i);
        assertEquals(null, cl.str);

        var data = Json.parse("IntData", "{\"i\":-12}");
        assertEquals(-12, data.i);
        assertEquals(SampleEnum.NONE, Json.parse("SampleEnum", "[\"NONE\"]"));

        var abst = Json.parse("SampleAbstract", "[\"NONE\"]");
        assertEquals("NONE", abst.name());
    }

    public function testPacker() {
        checkPacker(new JsonPacker());
    }
}