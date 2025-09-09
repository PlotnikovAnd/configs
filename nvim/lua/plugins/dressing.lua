return {
	'stevearc/dressing.nvim',
	config = function()
		require('dressing').setup({
			input = {
				win_options = {
					winhighlight = 'Normal:CmpPmunu,FloatBoarder:CmpPmenuBoarder,CursorLine:PmenuSel,Search:None'
				},
			}
		})
	end
}
