// VIM_TEST_SETUP setlocal nofoldenable
// VIM_TEST_SETUP let g:java_mark_braces_in_parens_as_errors = 1
// VIM_TEST_SETUP highlight link javaBlockOtherStart Structure
// VIM_TEST_SETUP highlight link javaBlockStart Todo


	@SuppressWarnings({
	"""
	bespoke
	/*
	 *
	 */
	/**
	 *
	 */
	///
	///
	///
	//
	//
	//
	{
	}
"""
})
class UnfoldingTests {
	interface Unfoldenable
	{
	}

	static {
		new Object() {
			{
				{
					new Object() {{{
						new Object() {{{}}};
					}}};
				}
			}
		};

		switch (0) {
			case 0:
			case 1: {
				break;
			}
			default: ;
		}
	}

	{ Object bb = ((Object) new byte[]{}); }
	{
out: {
		do {
			if (true)
				break out;
		} while (false);
}
	}
/*\\\*/	{
		(new java.util.function.Function<Object, Object>() {
			/**
			 * {@inheritDoc} */
			public Object apply(Object o) { return o; };
		}).apply(
		(new java.util.function.Function<Object, Object>() {
			/** {@inheritDoc}
			 */
			public Object apply(Object o) { return o; };
		}));
	}

	/**
	 * No operation.
	 */
	void noOp1() { }
	/** No operation. */
	void noOp2()
	{
	}
	/** No operation. */
	void noOp3() {
	}
	/** No operation. */
	void noOp4() {
	/*/\/\/\*/ ; }

	/// No operation.
	///
	///
	void noOp5() { }
	/// No operation.
	void noOp6()
	{
	}
	/// No operation.
	void noOp7() {
	}
	/// No operation.
	void noOp8() {
	/*/\/\/\*/ ; }
}

/*
 * Some note.
 * {
 * }
 */
/**
 * A summary.
 * {
 * }
 */
/// A summary.
/// {
/// }
//
// {
// }

/* 122|........................................................................................*/ interface Unfoldenable {
}
