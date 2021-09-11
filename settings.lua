data:extend({
	{
		type = "int-setting", name = "PPI_update_tick",
		setting_type = "runtime-global", localised_name = {"mod-setting-name.update-tick"},
		default_value = 120, minimal_value = 0, maximal_value = 8e4
	}, {
		type = "int-setting", name = "PPI_income",
		setting_type = "runtime-global", localised_name = {"income"},
		default_value = 10, minimal_value = 1, maximal_value = 8e4
	}
})
