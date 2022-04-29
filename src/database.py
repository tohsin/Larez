import pandas as pd
import gspread

def load_user_database():
    gc = gspread.service_account(filename="service_accnt.json")
    sh = gc.open("Larez_User")
    worksheet = sh.sheet1
    dataframe = pd.DataFrame(worksheet.get_all_records(), dtype = str)
    return dataframe, worksheet

def load_admin_database():
    gc = gspread.service_account(filename="service_accnt.json")
    sh = gc.open("Larez_User")
    worksheet =  sh.worksheet("Sheet2")
    dataframe = pd.DataFrame(worksheet.get_all_records(), dtype = str)
    return dataframe, worksheet

def update_admin_database(new_dataframe, worksheet):
    worksheet.update([new_dataframe.columns.values.tolist()] + new_dataframe.values.tolist())
    return worksheet
