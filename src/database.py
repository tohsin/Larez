import gspread
class Sheet:
    def __init__(self) -> None:
        sa = gspread.service_account(filename="service_accnt.json")
        sh = sa.open("Larez_User")
        self.load_userTable(sh)
        self.table = self.get_entireTable(self.usersheet)
        self.mapping_key = self.generate_indexMap('user', self.table[0])
        
        
    def load_userTable(self, sh)->None:
        self.usersheet =  sh.sheet1
    def create_new_user(self):
        pass
        
    def get_cell(self, row, col, worksheet):
        return worksheet.cell(row, col).value
    def edit_cell(self, row , col, worksheet, val):
        worksheet.update_cell(row, col, val)
        
    def get_row(worksheet, id):
        values_list = worksheet.row_values(id)
        return values_list
    
    def get_col(worksheet, id):
        values_list = worksheet.col_values(id)
        return values_list
    
    def get_entireTable(self, worksheet):
        list_of_lists = worksheet.get_all_values()
        return list_of_lists
    def get_entireTableUser(self):
        list_of_lists = self.usersheet.get_all_values()
        return list_of_lists
    
    def generate_indexMap(self, table, title_list)->dict:
        cache = {}
        if table=="user":
            idx  = 0
            for title in title_list:
                cache[title] = idx
                idx+=1 
            return cache

