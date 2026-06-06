#!/usr/bin/env python3

import matplotlib.pyplot as plt
import pandas as pd

# ----------------------------------------------------------------------
# Global style – larger base font
# ----------------------------------------------------------------------
plt.rcParams.update({
    'font.size': 14,          # base font size
    'axes.titlesize': 18,    # title
    'axes.labelsize': 16,    # axis labels
    'xtick.labelsize': 13,   # x‑tick labels
    'ytick.labelsize': 13,   # y‑tick labels
    'legend.fontsize': 13,
    'figure.titlesize': 20
})


def plot_bar(df, category_col, count_col, percent_col,
             title, filename, rotate_xticks=False,
             x_label='Kategoria', y_label='Liczba respondentów (n)',
             bar_color='steelblue'):
    """
    Creates a vertical bar plot with larger fonts and tilted axis labels.

    Parameters
    ----------
    df : pandas.DataFrame
    category_col : str – column with category names (x‑axis)
    count_col : str – raw counts (n)
    percent_col : str – percentages (shown on top of bars)
    title, filename : str
    rotate_xticks : bool – rotate x‑tick labels 90° (useful for long names)
    x_label, y_label : str – Polish axis labels
    bar_color : str – colour of the bars
    """
    fig, ax = plt.subplots(figsize=(12, 7))

    # bars
    bars = ax.bar(df[category_col], df[count_col], color=bar_color)

    # titles and axis labels
    # ax.set_title(title, pad=20)
    ax.set_xlabel(x_label, labelpad=15)
    ax.set_ylabel(y_label, labelpad=15)

    # tilt both axes' tick labels
    # ax.tick_params(axis='x', rotation=45, labelrotation=45)   # x‑ticks 45°
    # ax.tick_params(axis='y', rotation=30, labelrotation=30)   # y‑ticks 30°

    plt.tight_layout()
    plt.savefig(filename, dpi=300)
    #plt.show()

# ----------------------------------------------------------------------
# 1. Płeć badanych
# ----------------------------------------------------------------------
df_gender = pd.DataFrame({
    'Płeć': ['Kobieta', 'Mężczyzna'],
    'n': [90, 17],
    'procent': [84.1, 15.9]
})
plot_bar(df_gender, 'Płeć', 'n', 'procent',
         title='Płeć badanych',
         filename='plec-badanych.png',
         x_label='Płeć',
         y_label='Liczba respondentów (n)')

# ----------------------------------------------------------------------
# 2. Wiek badanych
# ----------------------------------------------------------------------
df_age = pd.DataFrame({
    'Wiek': ['< 20', '20–22', '23–25', '> 25'],
    'n': [10, 14, 24, 59],
    'procent': [9.3, 13.1, 22.4, 55.1]
})
plot_bar(df_age, 'Wiek', 'n', 'procent',
         title='Wiek badanych',
         filename='wiek-badanych.png',
         x_label='Grupa wiekowa',
         y_label='Liczba respondentów (n)')

# ----------------------------------------------------------------------
# 3. Rok studiów
# ----------------------------------------------------------------------

# SMU (Studia magisterskie uzupełniające)

df_year = pd.DataFrame({
    'Rok studiów': ['I', 'II', 'III', 'IV', 'V', 'SMU'],
    'n': [11, 11, 15, 40, 12, 18],
    'procent': [10.3, 10.3, 14.0, 37.4, 11.2, 16.8]
})
plot_bar(df_year, 'Rok studiów', 'n', 'procent',
         title='Rok studiów',
         filename='rok-studiow.png',
         rotate_xticks=True,
         x_label='Rok studiów',
         y_label='Liczba respondentów (n)')

# ----------------------------------------------------------------------
# 4. Kierunki studiów
# ----------------------------------------------------------------------
df_fields = pd.DataFrame({
    'Kierunek': [
        'PSY', 'DIET', 'INF', 'FILO', 'FiR', 'FIZ', 'LOGI', 'BUSI',
        'KiK', 'MED', 'PRAWO', 'PiP', 'ADMIN', 'BiP', 'BEZW', 'MSZT'
    ],
    #'Field': [
    #    'Psychologia', 'Dietetyka', 'Informatyka', 'Filologia',
    #    'Finanse i rachunkowość', 'Fizjoterapia', 'Logistyka',
    #    'Business', 'Kryminologia i kryminalistyka', 'Medycyna',
    #    'Prawo', 'Psychologia i psychoterapia', 'Administracja',
    #    'Behawiorystyka i psychologia zwierząt',
    #    'Bezpieczeństwo wewnętrzne', 'Mediacja sztuki'
    #],
    'n': [51, 27, 4, 3, 3, 3, 3, 2, 2, 2, 2, 2, 1, 1, 1, 1],
    'procent': [47.2, 25.0, 3.7, 2.7, 2.7, 2.7, 2.7,
                1.8, 1.8, 1.8, 1.8, 1.8, 0.9, 0.9, 0.9, 0.9]
})
plot_bar(df_fields, 'Kierunek', 'n', 'procent',
         title='Kierunki studiów',
         filename='kierunki-studiow.png',
         rotate_xticks=True,
         x_label='Kierunek studiów',
         y_label='Liczba respondentów (n)',
         bar_color='darkorange')

# ----------------------------------------------------------------------
# 5. Aktywność fizyczna
# ----------------------------------------------------------------------
df_activity = pd.DataFrame({
    'Aktywność fizyczna': [
        'Nidgy',
        '< 1',
        '1–2',
        '3–4',
        '> 5'
    ],
    # 'Activity': [
    #     'Nigdy',
    #     'Rzadziej niż raz w tygodniu',
    #     '1–2 razy w tygodniu',
    #     '3–4 razy w tygodniu',
    #     '5 lub więcej razy w tygodniu'
    # ],
    'n': [4, 36, 28, 25, 14],
    'procent': [3.7, 33.6, 26.2, 23.4, 13.1]
})
plot_bar(df_activity, 'Aktywność fizyczna', 'n', 'procent',
         title='Aktywność fizyczna',
         filename='aktywnosc-fizyczna.png',
         rotate_xticks=True,
         x_label='Częstotliwość',
         y_label='Liczba respondentów (n)',
         bar_color='seagreen')


# ----------------------------------------------------------------------
# 6. Aktualne stosowanie suplementów
# ----------------------------------------------------------------------
df_aktualne = pd.DataFrame({
    'Aktualne stosowanie suplementów': ['Tak', 'Nie'],
    'n'                               : [97, 10],
    'procent'                         : [90.7, 9.3]
})
plot_bar(df_aktualne,
         'Aktualne stosowanie suplementów',
         'n',
         'procent',
         title='Aktualne stosowanie suplementów',
         filename='aktualne-suplementy.png',
         rotate_xticks=False,
         x_label='Odpowiedź',
         y_label='Liczba respondentów (n)',
         bar_color='steelblue')


# ----------------------------------------------------------------------
# 7. Częstość stosowania suplementów
# ----------------------------------------------------------------------
df_czestosc = pd.DataFrame({
    'Częstość stosowania' : ['Codziennie',
                             'Kilka razy w tygodniu',
                             'Kilka razy w miesiącu',
                             'Sporadycznie'],
    'n'                  : [65, 21, 3, 18],
    'procent'            : [60.7, 19.6, 2.8, 16.8]
})
plot_bar(df_czestosc,
         'Częstość stosowania',
         'n',
         'procent',
         title='Częstość stosowania suplementów',
         filename='czestosc-suplementow.png',
         rotate_xticks=True,
         x_label='Częstość',
         y_label='Liczba respondentów (n)',
         bar_color='mediumseagreen')


# ----------------------------------------------------------------------
# 8. Czas stosowania suplementów
# ----------------------------------------------------------------------
df_czas = pd.DataFrame({
    'Czas stosowania' : ['< 3 miesięcy', '3–12 miesięcy', '1–3 lata', '>3 lat'],
    'n'               : [20, 23, 24, 40],
    'procent'         : [18.7, 21.5, 22.4, 37.4]
})
plot_bar(df_czas,
         'Czas stosowania',
         'n',
         'procent',
         title='Czas stosowania suplementów',
         filename='czas-suplementow.png',
         rotate_xticks=True,
         x_label='Czas',
         y_label='Liczba respondentów (n)',
         bar_color='coral')


# ----------------------------------------------------------------------
# 9. Rodzaje stosowanych suplementów
# ----------------------------------------------------------------------
df_rodzaje = pd.DataFrame({
    'Rodzaj suplementu' : ['WITD', 'KO3', 'MAG', 'PROB', 'WITC', 'MWIT', 'BIAŁ', 'INNE', 'KREA', 'ADAP'],
    # 'Rodzaj suplementu' : ['Witamina D', 'Kwasy omega-3', 'Magnez', 'Probiotyki', 'Witamina C',
    #                        'Multiwitaminy', 'Białko','Inne odpowiedzi', 'Kreatyna', 'Adaptogeny (np. ashwagandha)']
    'n'                : [89, 62, 51, 40, 37, 32, 24, 19, 15, 11],
    'procent'          : [83.2, 57.9, 47.7, 37.4, 34.6, 29.9, 22.4, 17.8, 14.0, 10.3]
})
plot_bar(df_rodzaje,
         'Rodzaj suplementu',
         'n',
         'procent',
         title='Rodzaje stosowanych suplementów',
         filename='rodzaje-suplementow.png',
         rotate_xticks=True,
         x_label='Suplement',
         y_label='Liczba respondentów (n)',
         bar_color='slateblue')


# ----------------------------------------------------------------------
# 10. Powody suplementacji
# ----------------------------------------------------------------------
df_powody = pd.DataFrame({
    'Powód stosowania' : ['POP-ZDR', 'WZM-ODP', 'ZAP-NIE', 'ZWI-ENE', 'POP-SAM', 'POP-KON', 'POP-WYG', 'INNE'],
    # 'Powód stosowania'               : ['Poprawa zdrowia',
    #                                     'Zapobieganie niedoborom',
    #                                     'Wzmocnienie odporności',
    #                                     'Poprawa wyglądu (skóra, włosy, paznokcie)',
    #                                     'Zwiększenie energii',
    #                                     'Poprawa koncentracji',
    #                                     'Poprawa samopoczucia',
    #                                     'Inne odpowiedzi'],
    'n'                              : [73, 73, 71, 54, 53, 49, 48, 5],
    'procent'                        : [68.2, 68.2, 66.4, 50.5, 49.5, 45.8, 44.9, 4.7]
})
plot_bar(df_powody,
         'Powód stosowania',
         'n',
         'procent',
         title='Powody suplementacji',
         filename='powody-suplementacji.png',
         rotate_xticks=True,
         x_label='Powód',
         y_label='Liczba respondentów (n)',
         bar_color='goldenrod')

