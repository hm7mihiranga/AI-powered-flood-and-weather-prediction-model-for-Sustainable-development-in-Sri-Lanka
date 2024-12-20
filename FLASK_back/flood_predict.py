from flask import Flask, render_template, request, jsonify
from joblib import load
import pandas as pd
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

model = load(r"E:\Projects\Weather_App_UI\weatherzen_model\predict_weather_rain\model.joblib")
print(model.get_params())

cat_columns = ['Gauging Station_Badalgama','Gauging Station_Baddegama',
               'Gauging Station_Calidonia','Gauging Station_Deduru Oya',
               'Gauging Station_Deraniyagala','Gauging Station_Dunamale',

               'Gauging Station_Ellagawa','Gauging Station_Galgamuwa',
               'Gauging Station_Giriulla','Gauging Station_Glencourse',
               'Gauging Station_Hanwella','Gauging Station_Holombuwa',
               'Gauging Station_Horowpathana','Gauging Station_Kalawellawa',
               'Gauging Station_Katharagama','Gauging Station_Kitulgala',
               'Gauging Station_Kuda Oya','Gauging Station_Magura',
               'Gauging Station_Manampitiya(HMIS)','Gauging Station_Manampitiya(Old)',
               'Gauging Station_Moragaswewa','Gauging Station_Moraketiya',
               "Gauging Station_N' Street",'Gauging Station_Nakkala',
               'Gauging Station_Nawalapitiya','Gauging Station_Norwood',
               'Gauging Station_Padiyathalawa','Gauging Station_Panadugama',
               'Gauging Station_Peradeniya','Gauging Station_Pitabeddara',
               'Gauging Station_Putupaula','Gauging Station_Rathnapura',
               'Gauging Station_Ridi bendi Ella (Dam)','Gauging Station_Siyambalanduwa',
               'Gauging Station_Thaldena','Gauging Station_Thalgahagoda',
               'Gauging Station_Thanamalwila','Gauging Station_Thanthirimale',
               'Gauging Station_Thawalama','Gauging Station_Urawa',
               'Gauging Station_Wellawaya','Gauging Station_Weraganthota',
               'Gauging Station_Yaka Wewa']


flood_levels = {
    "N' Street": {"alert": 4, "minor_flood": 5, "major_flood": 7},
    "Hanwella": {"alert": 7, "minor_flood": 8, "major_flood": 10},
    "Glencourse": {"alert": 15, "minor_flood": 16.5, "major_flood": 19},
    "Kitulgala": {"alert": 3, "minor_flood": 4, "major_flood": 6},
    "Holombuwa": {"alert": 3, "minor_flood": 3.4, "major_flood": 5},
    "Deraniyagala": {"alert": 4.8, "minor_flood": 5.8, "major_flood": 6.4},
    "Norwood": {"alert": 1.5, "minor_flood": 3, "major_flood": 4.5},
    "Putupaula": {"alert": 3, "minor_flood": 4, "major_flood": 5},
    "Ellagawa": {"alert": 10, "minor_flood": 10.7, "major_flood": 12.2},
    "Rathnapura": {"alert": 5.2, "minor_flood": 7.5, "major_flood": 9.5},
    "Magura": {"alert": 4, "minor_flood": 6, "major_flood": 7.5},
    "Kalawellawa": {"alert": 5, "minor_flood": 6.5, "major_flood": 8},
    "Thawalama": {"alert": 4, "minor_flood": 6, "major_flood": 7.5},
    "Baddegama": {"alert": 3.5, "minor_flood": 4, "major_flood": 5},
    "Thalgahagoda": {"alert": 1.4, "minor_flood": 1.7, "major_flood": 2.8},
    "Panadugama": {"alert": 5, "minor_flood": 6, "major_flood": 7.5},
    "Pitabeddara": {"alert": 4, "minor_flood": 5, "major_flood": 6.5},
    "Urawa": {"alert": 2.5, "minor_flood": 4, "major_flood": 6},
    "Moraketiya": {"alert": 1.8, "minor_flood": 3.5, "major_flood": 5},
    "Thanamalwila": {"alert": 4, "minor_flood": 5, "major_flood": 5.5},
    "Wellawaya": {"alert": 4.4, "minor_flood": 5.4, "major_flood": 5.9},
    "Kuda Oya": {"alert": 6.9, "minor_flood": 8.4, "major_flood": 8.8},
    "Katharagama": {"alert": 4, "minor_flood": 4.6, "major_flood": 6.5},
    "Nakkala": {"alert": 5, "minor_flood": 6, "major_flood": 7.5},
    "Siyambalanduwa": {"alert": 4.5, "minor_flood": 6, "major_flood": 7},
    "Padiyathalawa": {"alert": 4, "minor_flood": 4.5, "major_flood": 6},
    "Manampitiya(Old)": {"alert": 3.5, "minor_flood": 5, "major_flood": 6},
    "Manampitiya(HMIS)": {"alert": 4.65, "minor_flood": 6.15, "major_flood": 7.15},
    "Weraganthota": {"alert": 5, "minor_flood": 6, "major_flood": 8},
    "Peradeniya": {"alert": 5, "minor_flood": 7, "major_flood": 9},
    "Nawalapitiya": {"alert": 3.5, "minor_flood": 5, "major_flood": 6},
    "Thaldena": {"alert": 3, "minor_flood": 4, "major_flood": 5},
    "Calidonia": {"alert": 3, "minor_flood": 3.5, "major_flood": 4.5},
    "Horowpathana": {"alert": 6, "minor_flood": 7.5, "major_flood": 10.5},
    "Yaka Wewa": {"alert": 4, "minor_flood": 5, "major_flood": 6},
    "Thanthirimale": {"alert": 5, "minor_flood": 6.8, "major_flood": 7.8},
    "Galgamuwa": {"alert": 4.84, "minor_flood": 5.94, "major_flood": 8},
    "Deduru Oya": {"alert": 3.3, "minor_flood": 4.2, "major_flood": 4.7},
    "Badalgama": {"alert": 5, "minor_flood": 6.2, "major_flood": 9.6},
    "Giriulla": {"alert": 5.5, "minor_flood": 6.5, "major_flood": 7.5},
    "Dunamale": {"alert": 3.3, "minor_flood": 4.4, "major_flood": 5.5}
}


def predict_water_levels(gauging_station, rainfall):
    input_data = {col: 0 for col in cat_columns}
    gauging_station_column = f'Gauging Station_{gauging_station}'
    print(gauging_station_column)
    if gauging_station_column in input_data:
        print(input_data[gauging_station_column])
        input_data[gauging_station_column] = 1
    else:
        raise ValueError(f"Invalid Gauging Station: {gauging_station}")

    input_data['24hr Rainfall'] = rainfall
    input_df = pd.DataFrame([input_data])

    return model.predict(input_df)

def determine_flood_status(region, water_level):
    thresholds = flood_levels.get(region)

    if thresholds is None:
        return "Unknown Region"

    if water_level < thresholds["alert"]:
        return "Normal"
    elif water_level < thresholds["minor_flood"]:
        return "Alert"
    elif water_level < thresholds["major_flood"]:
        return "Minor Flood"
    else:
        return "Major Flood"

@app.route('/', methods=['GET', 'POST'])
def index():
    return render_template("index15.html")

@app.route('/predict', methods=['POST'])
def predict():
    region = request.form['region']
    rainfall = float(request.form['rainfall'])

    predictions = predict_water_levels(region, rainfall)
    predicted_level_1hr_ago = predictions[0][0]
    predicted_level_1hr_after = predictions[0][1]

    risk_status = determine_flood_status(region, predicted_level_1hr_after)

    return jsonify({
        'predicted_level_1hr_ago': predicted_level_1hr_ago,
        'predicted_level_1hr_after': predicted_level_1hr_after,
        'risk_status': risk_status
    })
    # return render_template('index15.html',
    #                        predicted_level_1hr_ago=predicted_level_1hr_ago,
    #                        predicted_level_1hr_after=predicted_level_1hr_after,
    #                        risk_status=risk_status)

if __name__ == '__main__':
    app.run(host='127.0.0.2', port=8000)  # Replace with your machine's IP

