# Import necessary libraries
import numpy as np
import pandas as pd
import datetime as dt
import flask
from flask import Flask, jsonify
import sqlalchemy
from sqlalchemy.util import deprecations
deprecations.SILENCE_UBER_WARNING = True
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func, inspect

# Database Setup
file = "./Resources/hawaii.sqlite"
conn_str = f"sqlite:///{file}"
engine= create_engine(conn_str)

# Reflect an existing database into a new model
Base = automap_base()
Base.prepare(engine, reflect=True)
# Save references to each table
measurement = Base.classes.measurement
station = Base.classes.station
# Create our session (link) from Python to the DB
session = Session(engine)
# Flask Setup
from flask import Flask, jsonify
app = Flask(__name__)

# Flask Routes

# Route for the root URL '/'
# List all available api routes
@app.route('/')
def home():
    return (
        f"Available Routes:<br/>"
        f"/api/v1.0/precipitation<br/>"
        f"/api/v1.0/stations<br/>"
        f"/api/v1.0/tobs<br/>"
        f"/api/v1.0/temp_calc/&lt;start&gt;<br/>"
        f"/api/v1.0/temp_calc/&lt;start&gt;/&lt;end&gt;"
    )


@app.route("/api/v1.0/precipitation")
def precipitation():
# Convert the query results from your precipitation analysis to a dictionary
    year_ago = dt.date(2017, 8, 23) - dt.timedelta(days = 365)
    result= session.query(measurement.date, func.avg(measurement.prcp)).filter(measurement.date >= year_ago).group_by(measurement.date).all()
    
    
# Defining DataFrames
    df = pd.DataFrame(result, columns = ['Date', "Precipitation"])
    precip_dict =df.set_index('Date').T.to_dict('list')
    session.close()
    return jsonify(precip_dict)


@app.route('/api/v1.0/stations')
def api_station():
# Return a JSON list of stations from the dataset
    result=session.query(station.station).all()
    result_list = list(np.ravel(result))
    session.close()
    return jsonify(result_list)


@app.route('/api/v1.0/tobs') 
def api_tobs():
# Query the dates and temperature observations of the most-active station for the previous year of data
    session = Session(engine)
    active_station= session.query(measurement.station , func.count(measurement.station)).group_by( measurement.station ).order_by(func.count(measurement.station).desc()).all()
    best_station= active_station[0][0]
    year_ago= dt.date(2017, 8, 18) - dt.timedelta(days = 365)
    result =  session.query(measurement.date,measurement.tobs).filter(measurement.station == best_station).filter(measurement.date >=year_ago).all()
    result_list = list(np.ravel(result))
    session.close()
    return jsonify(result_list)


@app.route('/api/v1.0/temp_calc/<start>')
@app.route('/api/v1.0/temp_calc/<start>/<end>')
def calc_temps(start, end=dt.date(dt.MAXYEAR, 12, 31)):
# A start route temp_calc that accepts the start date 2016-08-23 as a parameter from the URL
# Returns the min, max, and average temperatures calculated from the given start date to the end of the dataset
# A start/end route temp_calc that accepts the start 2016-0-23 and end dates as parameters from the URL   
# Returns the min, max, and average temperatures calculated from the given start date to the given end date  
        
    """TMIN, TAVG, and TMAX for a list of dates.
    Args:
        start_date (string): A date string in the format %Y-%m-%d
        end_date (string): A date string in the format %Y-%m-%d
    Returns:
        TMIN, TAVG, and TMAX
    """
    session = Session(engine)
    results = session.query(func.min(measurement.tobs), func.avg(measurement.tobs), func.max(measurement.tobs)).\
        filter(measurement.date >= start).\
        filter(measurement.date <= end).first()
    session.close()
    return jsonify(list(results))
    
    
# Run the application if this script is executed
if __name__ == '__main__':
# Run the app in debug mode for development
    app.run(debug=True)







