# CGM metric function
def cgm_metrics(cleaned_data):
    # Store results
    results = {"id":[],"total_sensor_readings":[],"percent_cgm_wear":[],"mean_sensor":[],"sensor_sd":[],
               "percent_time_under_54":[],"minutes_under_54":[],"num_values_under_54":[],
               "percent_time_55_69":[],"minutes_55_69":[],"num_values_55_69":[],
               "percent_time_70_180":[],"minutes_70_180":[],"num_values_70_180":[],
               "percent_time_181_250":[],"minutes_181_250":[],"num_values_181_250":[],
               "percent_time_over_250":[],"minutes_over_250":[],"num_values_over_250":[]}
    # Variables
    c = Counter(cleaned_data["id"])
    results["id"].append(c.most_common(1)[0][0])
    # CGM wear metrics
    total_r = cleaned_data["glucose"].notna().sum()
    results["total_sensor_readings"].append(total_r)
    results["percent_cgm_wear"].append(round(total_r / cleaned_data.shape[0] * 100,2))
    # Mean and SD
    results["mean_sensor"].append(round(cleaned_data["glucose"].mean(skipna = True),2))
    results["sensor_sd"].append(round(cleaned_data["glucose"].std(skipna = True),2))
    # Hypoglycemia
    # Under 54
    hypo_54 = [g for g in cleaned_data["glucose"] if g <= 54]
    results["percent_time_under_54"].append(round(len(hypo_54) / total_r * 100,2))
    results["minutes_under_54"].append(len(hypo_54) * (s / 60))
    results["num_values_under_54"].append(len(hypo_54))
    # >= 55 and < 70
    hypo_55_69 = [g for g in cleaned_data["glucose"] if g >= 55 and g < 70]
    results["percent_time_55_69"].append(round(len(hypo_55_69) / total_r * 100,2))
    results["minutes_55_69"].append(len(hypo_55_69) * (s / 60))
    results["num_values_55_69"].append(len(hypo_55_69))
    # TIR 
    tir = [g for g in cleaned_data["glucose"] if g >= 70 and g <= 180]
    results["percent_time_70_180"].append(round(len(tir) / total_r * 100,2))
    results["minutes_70_180"].append(len(tir) * (s / 60))
    results["num_values_70_180"].append(len(tir))
     # 181 - 250
    hyper_181_250 = [g for g in cleaned_data["glucose"] if g > 180 and g <= 250]
    results["percent_time_181_250"].append(round(len(hyper_181_250) / total_r * 100,2))
    results["minutes_181_250"].append(len(hyper_181_250) * (s / 60))
    results["num_values_181_250"].append(len(hyper_181_250))
    # Over 150
    hyper_250 = [g for g in cleaned_data["glucose"] if g > 250]
    results["percent_time_over_250"].append(round(len(hyper_250) / total_r * 100,2))
    results["minutes_over_250"].append(len(hyper_250) * (s / 60))
    results["num_values_over_250"].append(len(hyper_250))
    # Return results
    return results