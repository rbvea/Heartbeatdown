enum Node {
	Branch(difficulty: Int, right: Node, left: Node, pointArray: Array<Point>);
	Leaf;
}

class Point
{
	public var x: Int;
	public var y: Int;

	public function new(x: Int, y: Int)
	{
		this.x = x;
		this.y = y;
	}
}

class Map 
{
	public var startNode: Node;
	public function new()
	{
		this.startNode = makeMap1();
	}

	private function makeMap1(): Node
	{
		var p0 = new Point(1, 1);
		var p1 = new Point(1, 1);
		var p2 = new Point(1, 1);
		var p3 = new Point(1, 1);
		var p4 = new Point(1, 1);
		var p5 = new Point(1, 1);
		var p6 = new Point(1, 1);
		var p7 = new Point(1, 1);
		var p8 = new Point(1, 1);
		var p9 = new Point(1, 1);
		var p10 = new Point(1, 1);
		var p11 = new Point(1, 1);
		var p12 = new Point(1, 1);
		var p13 = new Point(1, 1);
		var p14 = new Point(1, 1);
		var p15 = new Point(1, 1);
		var p16 = new Point(1, 1);
		var p17 = new Point(1, 1);
		var p18 = new Point(1, 1);
		var p19 = new Point(1, 1);
		var p20 = new Point(1, 1);
		var p21 = new Point(1, 1);
		var p22 = new Point(1, 1);
		var p23 = new Point(1, 1);
		var p24 = new Point(1, 1);
		var p25 = new Point(1, 1);
		var p26 = new Point(1, 1);
		var p27 = new Point(1, 1);
		var p28 = new Point(1, 1);
		var p29 = new Point(1, 1);
		var p30 = new Point(1, 1);
		var p31 = new Point(1, 1);
		var p32 = new Point(1, 1);
		var p33 = new Point(1, 1);
		var n17 =  Branch(1, Leaf, Leaf, [p17, p18, p19, p12]);
		var n16 =  Branch(3, Leaf, Leaf, [p17, p20, p12]);
		var n15 =  Branch(1, n16, n17, [p28, p13, p14, p15, p16, p17]);
		var n13 =  Branch(3, Leaf, Leaf, [p20, p12]);
		var n12 =  Branch(2, Leaf, Leaf, [p23, p9, p10, p11, p12]);
		var n10 =  Branch(3, n12, n13, [p24, p25, p26, p21, p22, p23]);
		var n9 =  Branch(2, n16, n17, [p8, p13, p14, p15, p16, p17]);
		var n8 =  Branch(2, Leaf, Leaf, [p2, p24]);
		var n14 =  Branch(2, n8, n9, [p28, p7, p8]);
		var n11 =  Branch(1, n14, n15, [p24, p27]);
		var n7 =  Branch(3, n12, n13, [p6, p21, p22, p23]);
		var n6 =  Branch(2, n8, n9, [p6, p7]);
		var n5 =  Branch(2, n10, n11, [p2, p24]);
		var n4 =  Branch(2, n6, n7, [p2, p3, p4, p5, p6]);
		var n3 =  Branch(1, n14, n15, [p1, p29, p30, p31, p32, p33, p27, p28]);
		var n2 =  Branch(2, n4, n5, [p1, p2]);
		var n1 =  Branch(1, n2, n3, [p0, p1]);
		return n1;
	}
}