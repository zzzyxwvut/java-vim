// VIM_TEST_SETUP let g:java_syntax_previews = [468]
// VIM_TEST_SETUP let g:java_highlight_generics = 1


// VIM_TEST_SETUP hi link javaOperator Todo

class DerivedRecordsTests	// JDK ??+ (--enable-preview --release ??).
{
	record P2<A, B>(A a, B b)
	{
		P2<A, B> withA(A newA) { return new P2<>(newA, b); }
		P2<A, B> withB(B newB) { return this with { b = newB; }; }
	}

	static {
		final P2<P2<Short, Short>, P2<Short, Short>> pA =
				switch (new P2<>(new P2<>((short) 1,
							(short) 2),
						new P2<>((short) 11,
							(short) 12))) {
			case P2(P2(Short a0, Short b0),
					P2(Short a1, Short b1)) ->
								new P2<>(
				new P2<>((short) (a0 + 1),	//  1 + 1
					(short) (b0 + 1)),	//  2 + 1
				new P2<>((short) (a1 + 1),	// 11 + 1
					(short) (b1 + 1)));	// 12 + 1
		};

		final P2<P2<Short, Short>, P2<Short, Short>> pB =
					new P2<>(new P2<>((short) 1,
							(short) 2),
						new P2<>((short) 11,
							(short) 12)) with
		{
			a = a with {
				a += (short) 1;	//  1 + 1
				b += (short) 1;	//  2 + 1
			};
		}with{
			b = b with					{
				a += (short) 1;	// 11 + 1
				b += (short) 1;	// 12 + 1
			};
		};
	}
}
