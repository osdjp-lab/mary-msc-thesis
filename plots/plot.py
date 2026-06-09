#!/usr/bin/env python3

import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns   # easier handling of box‑plots & jitter

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
    plt.close()

def plot_barh(df, category_col, count_col, percent_col,
              title, filename, rotate_yticks=False,
              y_label='Kategoria', x_label='Liczba respondentów (n)',
              bar_color='steelblue'):
    """
    Creates a **horizontal** bar plot using the same styling as `plot_bar`.

    Parameters
    ----------
    df : pandas.DataFrame
    category_col : str – column with category names (y‑axis)
    count_col    : str – raw counts (n)
    percent_col : str – percentages (shown at the end of each bar)
    title, filename : str
    rotate_yticks : bool – rotate y‑tick labels 90° (useful for long names)
    y_label, x_label : str – Polish axis labels (note the swapped order)
    bar_color : str – colour of the bars
    """
    fig, ax = plt.subplots(figsize=(12, 7))

    # horizontal bars
    bars = ax.barh(df[category_col], df[count_col], color=bar_color)

    ax.set_ylabel(y_label, labelpad=15)
    ax.set_xlabel(x_label, labelpad=15)

    if rotate_yticks:
        ax.tick_params(axis='y', rotation=90)

    # write percentages at the end of each bar
    # for rect, pct in zip(bars, df[percent_col]):
    #     ax.text(rect.get_width() + max(df[count_col])*0.01,   # small offset
    #             rect.get_y() + rect.get_height()/2,
    #             f'{pct:.1f}%',
    #             ha='left', va='center',
    #             fontsize=12)

    # plt.title(title, pad=20)
    plt.tight_layout()
    plt.savefig(filename, dpi=300)
    # plt.show()
    plt.close()

def plot_three_vars_box(df,
                        vars_list,
                        title,
                        filename,
                        rotate_xticks=False,
                        x_label='Zmienna',
                        y_label='Wartość (1‑5)',
                        palette='Set2',
                        show_points=True,
                        point_alpha=0.6):
    """
    Creates a box‑plot with the three questionnaire items on the x‑axis
    and the Likert ratings (1‑5) on the y‑axis.

    Parameters
    ----------
    df          : pandas.DataFrame containing the raw columns.
    vars_list   : list of three column names to plot (e.g. ['general','safety','interaction']).
    title, filename : strings.
    rotate_xticks : bool – rotate the variable labels 90° (useful if you add many items later).
    x_label, y_label : axis titles.
    palette     : seaborn colour palette.
    show_points : overlay jittered raw observations.
    point_alpha : transparency of the overlay points.
    """
    # ----------------------------------------------------------
    # Reshape to long format  (variable, value)
    # ----------------------------------------------------------
    long_df = df[vars_list].melt(var_name='Zmienna', value_name='Wartość')
    # Ensure the rating column is treated as numeric (it already is)
    long_df['Wartość'] = pd.to_numeric(long_df['Wartość'])

    # ----------------------------------------------------------
    # Plot
    # ----------------------------------------------------------
    fig, ax = plt.subplots(figsize=(10, 6))

    sns.boxplot(data=long_df,
                x='Zmienna',
                y='Wartość',
                palette=palette,
                width=0.6,
                showfliers=False,
                ax=ax)

    if show_points:
        # Jittered strip of the individual responses
        sns.stripplot(data=long_df,
                      x='Zmienna',
                      y='Wartość',
                      color='black',
                      size=5,
                      jitter=True,
                      alpha=point_alpha,
                      dodge=True,
                      ax=ax)

    # ----------------------------------------------------------
    # Titles / labels / tick handling
    # ----------------------------------------------------------
    # ax.set_title(title, pad=20)
    ax.set_xlabel(x_label, labelpad=15)
    ax.set_ylabel(y_label, labelpad=15)

    if rotate_xticks:
        ax.tick_params(axis='x', rotation=90)

    # Force the y‑axis to show the full Likert range
    ax.set_ylim(0.5, 5.5)
    ax.set_yticks([1, 2, 3, 4, 5])

    plt.tight_layout()
    plt.savefig(filename, dpi=300)
    plt.close()

# ----------------------------------------------------------------------
# 1. Płeć badanych - 2
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
# 2. Wiek badanych - 3
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
# 3. Rok studiów - 5
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
# 4. Kierunki studiów - 4
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
# 5. Aktywność fizyczna - 6
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
# 6. Aktualne stosowanie suplementów - 7
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
# 7. Częstość stosowania suplementów - 8
# ----------------------------------------------------------------------
df_czestosc = pd.DataFrame({
    'Częstość stosowania' : ['Codziennie',
                             'Kilka razy w tygodniu',
                             'Kilka razy w miesiącu',
                             'Sporadycznie'],
    'n'                  : [63, 21, 3, 10],
    'procent'            : [64.95, 21.65, 3.1, 10.3]
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
# 8. Czas stosowania suplementów - 9
# ----------------------------------------------------------------------
df_czas = pd.DataFrame({
    'Czas stosowania' : ['< 3 miesięcy', '3–12 miesięcy', '1–3 lata', '>3 lat'],
    'n'               : [15, 23, 22, 37],
    'procent'         : [15.46, 23.71, 22.68, 38.15]
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
# 9. Rodzaje stosowanych suplementów - 10
# ----------------------------------------------------------------------
df_rodzaje = pd.DataFrame({
    'Rodzaj suplementu' : ['WITD', 'KO3', 'MAG', 'PROB', 'INNE',
                           'MWIT', 'WITC', 'BIAŁ', 'KREA', 'ADAP'],
    # 'Rodzaj suplementu' : ['Witamina D', 'Kwasy omega-3', 'Magnez', 'Probiotyki',
    #                        'Inne odpowiedzi', 'Witamina C', 'Multiwitaminy',
    #                        'Białko', 'Kreatyna', 'Adaptogeny (np. ashwagandha)']
    'n'                : [79, 59, 48, 40, 39, 32, 31, 24, 15, 11],
    'procent'          : [81.4, 60.8, 49.4, 41.2, 40.2, 32.9, 31.9, 24.7, 15.4, 11.3]
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
# 10. Powody suplementacji - 15
# ----------------------------------------------------------------------
df_powody = pd.DataFrame({
    'Powód stosowania' : ['POP-ZDR', 'WZM-ODP', 'ZAP-NIE', 'POP-SAM',
                          'ZWI-ENE', 'POP-WYG', 'POP-KON', 'INNE'],
    # 'Powód stosowania'               : ['Poprawa zdrowia',
    #                                     'Wzmocnienie odporności',
    #                                     'Zapobieganie niedoborom',
    #                                     'Poprawa samopoczucia',
    #                                     'Zwiększenie energii',
    #                                     'Poprawa wyglądu (skóra, włosy, paznokcie)',
    #                                     'Poprawa koncentracji',
    #                                     'Inne odpowiedzi'],
    'n'                              : [68, 66, 65, 50, 49, 46, 44, 4],
    'procent'                        : [70.1, 68.04, 67.01, 51.55, 50.52, 47.42, 45.36, 4.12]
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


# ----------------------------------------------------------------------
# 11. Źródła informacji o suplementach - 16
# ----------------------------------------------------------------------
df_zrodla = pd.DataFrame({
    'Źródło' : ['INT', 'LEK', 'DIET', 'MED-SPO', 'ZNA-ROD', 'FARM', 'REK', 'INNE'],
    # 'Źródło'               : ['Internet (artykuły, blogi)',
    #                           'Lekarz',
    #                           'Dietetyk',
    #                           'Media społecznościowe',
    #                           'Znajomi/rodzina',
    #                           'Farmaceuta',
    #                           'Reklamy',
    #                           'Inne odpowiedzi'],
    'n' : [67, 39, 37, 31, 29, 27, 10, 10],
    'procent' : [69.07, 40.21, 38.14, 31.96, 29.9, 27.84, 10.31, 10.31]
})
plot_bar(df_zrodla,
          'Źródło',
          'n',
          'procent',
          title='Źródła informacji',
          filename='zrodla-informacji.png',
          rotate_xticks=True,
          x_label='Źródło informacji',
          y_label='Liczba respondentów (n)',
          bar_color='olive')


# ----------------------------------------------------------------------
# 12. Najbardziej wiarygodne źródła - 27
# ----------------------------------------------------------------------
df_wiarygodne = pd.DataFrame({
    'Źródło' : ['LEK', 'NAUK', 'INST', 'DIET', 'FARM', 'BAD', 'PROF', 'FUNK', 'ZBR'],
    # 'Źródła'               : ['Lekarz',
    #                           'Naukowe portale internetowe',
    #                           'Instytucje zdrowia publicznego',
    #                           'Dietetyk',
    #                           'Farmaceuta',
    #                           'Badania naukowe',
    #                           'Takie, którego polecenia nie wynikają z profitów jakie otrzymują',
    #                           'Lekarze medycyny funkcjonalnej',
    #                           'Portale zbierające wyniki badań lub też oponie specjalistów, ale wielu, żeby mozna było porównać podejścia, nie ufam jednemu lekarzowi, dietetykowi itp. ponieważ każdy mówi co innego'],
    'n'                              : [27, 21, 18, 17, 10, 1, 1, 1, 1],
    'procent'                        : [27.84, 21.65, 18.56, 17.53, 10.31, 1.03, 1.03, 1.03, 1.03]
})
plot_bar(df_wiarygodne,
         'Źródło',
         'n',
         'procent',
         title='Wiarygodne źródła',
         filename='wiarygodne-zrodla.png',
         rotate_xticks=True,
         x_label='Źródło informacji',
         y_label='Liczba respondentów (n)',
         bar_color='orange')


# ----------------------------------------------------------------------
# 12. Preferowane formy edukacji - 26
# ----------------------------------------------------------------------
df_preferowane = pd.DataFrame({
    'Źródło' : ['KFE', 'ART', 'WAR', 'INF', 'KON', 'POS', 'POD', 'INNE'],
    # 'Źródła'               : ['Krótkie filmy edukacyjne',
    #                           'Artykuły popularnonaukowe',
    #                           'Warsztaty na uczelni',
    #                           'Infografiki',
    #                           'Konsultacje z farmaceutą',
    #                           'Posty na Instagramie/TikToku',
    #                           'Podcasty',
    #                           'Inne odpowiedzi'],
    'n'         : [53, 45, 39, 32, 32, 32, 29, 5],
    'procent'   : [54.64, 46.39, 40.21, 32.99, 32.99, 32.99, 29.9, 5.15]
})
plot_bar(df_preferowane,
         'Źródło',
         'n',
         'procent',
         title='Preferowane źródła',
         filename='preferowane-zrodla.png',
         rotate_xticks=True,
         x_label='Forma',
         y_label='Liczba respondentów (n)',
         bar_color='blue')

# ----------------------------------------------------------------------
# Przekraczanie zalecanych dawek - 11
# ----------------------------------------------------------------------

df_dawka= pd.DataFrame({
    'odp' : ['NIDGY', 'SPRD', 'CZST', 'BRAK'],
    # 'odp' : ['Nigdy – stosuję się ściśle do zaleceń.',
    #          'Sporadycznie (np. gdy czuję, że "bierze mnie przeziębienie").'
    #          'Często – uważam, że standardowe dawki są zbyt niskie.',
    #          'Nie czytam zaleceń dotyczących dawkowania na opakowaniu.'],
    'n'         : [53, 26, 12, 6],
    'procent'   : [54.64, 26.8, 12.37, 6.19]
})
plot_bar(df_dawka,
         'odp',
         'n',
         'procent',
         title='Przekraczanie dawki',
         filename='dawka.png',
         rotate_xticks=True,
         x_label='Przekraczanie dawki',
         y_label='Liczba respondentów (n)',
         bar_color='purple')


# ----------------------------------------------------------------------
# Sprawdzanie powielania składników - 12
# ----------------------------------------------------------------------

df_skladniki= pd.DataFrame({
    'Skład' : ['TAK', 'CZASAMI', 'NIE', 'JEDEN'],
    # 'Skład'               : ['Tak, zawsze analizuję składy pod kątem powtarzających się substancji.',
    #                          'Czasami zwracam na to uwagę',
    #                          'Nie, nie sprawdzam tego.',
    #                          'Stosuję tylko jeden preparat.'],
    'n'         : [58, 17, 13, 9],
    'procent'   : [59.79, 17.53, 13.4, 9.28]
})
plot_bar(df_skladniki,
         'Skład',
         'n',
         'procent',
         title='Składniki',
         filename='skladniki.png',
         rotate_xticks=True,
         x_label='Sprawdzanie składników',
         y_label='Liczba respondentów (n)',
         bar_color='orange')


# ----------------------------------------------------------------------
# Badania krwi przed suplementacją - 13
# ----------------------------------------------------------------------

df_badania= pd.DataFrame({
    'odp' : ['NKT', 'TAK', 'NIE', 'OBS'],
    # 'odp' : ['Zrobiłem/am badania tylko w przypadku niektórych preparatów.',
    #          'Tak, każdą suplementację konsultuję z wynikami badań',
    #          'Nie, stosuję suplementy bez wykonywania wcześniejszych badań.',
    #          'Suplementy dobieram na podstawie własnych obserwacji (np. gorsze samopoczucie, wypadanie włosów).'],
    'n'         : [34, 24, 23, 16],
    'procent'   : [35.05, 24.74, 23.71, 16.5]
})
plot_bar(df_badania,
         'odp',
         'n',
         'procent',
         title='Badania',
         filename='badania.png',
         rotate_xticks=True,
         x_label='Badania',
         y_label='Liczba respondentów (n)',
         bar_color='red')


# ----------------------------------------------------------------------
# Konsultacja ze specjalistą -  14
# ----------------------------------------------------------------------

df_konsultacja= pd.DataFrame({
    'odp' : ['NIE', 'DIET', 'FARM', 'LEK', 'INNE'],
    # 'odp' : ['Nie, nie konsultuję', 'Tak, z dietetykiem',
    #          'Tak, z farmaceutą', 'Tak, z lekarzem', 'Inne'],
    'n'         : [46, 24, 15, 6, 6],
    'procent'   : [47.42, 24.74, 15.46, 6.19, 6.19]
})
plot_bar(df_konsultacja,
         'odp',
         'n',
         'procent',
         title='Konsultacja',
         filename='konsultuja.png',
         rotate_xticks=True,
         x_label='Konsultuje',
         y_label='Liczba respondentów (n)',
         bar_color='brown')

# ----------------------------------------------------------------------
# Indeks prawidłowych praktyk suplementacyjnych
# ----------------------------------------------------------------------

df_indeks= pd.DataFrame({
    'indeks'     : [0, 1, 2, 3, 4],
    'n'       : [9, 31, 30, 19, 8],
    'procent' : [9.27, 31.96, 30.93, 19.59, 8.25],
})
plot_bar(df_indeks,
         'indeks',
         'n',
         'procent',
         title='Indeks',
         filename='indeks-praktyk.png',
         rotate_xticks=True,
         x_label='Indeks',
         y_label='Liczba respondentów (n)',
         bar_color='orange')

# ----------------------------------------------------------------------
# Kategorie praktyk
# ----------------------------------------------------------------------

df_kategorie= pd.DataFrame({
    'kategoria'     : ['Niska prawidłowość', 'Umiarkowana prawidłowość', 'Wysoka prawidłowość'],
    'n'       : [40, 30, 27],
    'procent' : [41.24, 30.93, 27.84]
})
plot_bar(df_kategorie,
         'kategoria',
         'n',
         'procent',
         title='Kategorie',
         filename='kategorie-praktyk.png',
         rotate_xticks=True,
         x_label='Kategoria',
         y_label='Liczba respondentów (n)',
         bar_color='orange')

# ----------------------------------------------------------------------
# Wykres pudełkowy samoocena
# ----------------------------------------------------------------------

data = {
    "Ogólna wiedza" : [4,2,3,4,4,4,5,5,4,4,3,5,4,4,4,4,5,2,5,4,5,5,3,4,4,5,5,4,4,3,1,3,2,4,4,3,1,2,2,3,4,3,5,3,2,2,2,2,4,3,4,2,4,3,4,3,2,2,4,2,3,4,4,3,4,4,2,4,4,3,4,4,5,4,4,4,3,4,4,4,4,4,3,4,3,1,5,4,4,2,5,3,3,3,2,3,3],
    "Wiedza o bezpieczeństwie" : [4,1,2,4,4,4,5,5,4,3,2,5,3,5,4,5,5,3,5,4,5,5,3,4,5,5,5,4,4,3,1,2,2,4,3,4,1,2,3,2,3,4,5,3,2,2,3,2,4,3,4,2,3,3,4,3,1,2,5,1,4,3,4,2,4,3,2,4,4,3,4,4,5,4,2,4,3,3,4,4,4,4,3,3,3,1,5,5,4,3,4,3,3,4,4,2,3],
    "Wiedza o interakcjach" : [4,1,2,4,4,4,5,5,4,3,3,5,3,4,4,5,5,4,5,4,5,5,3,3,4,5,5,4,3,3,1,3,1,4,3,4,1,1,4,1,3,3,5,3,2,2,4,1,3,2,3,3,2,3,4,2,2,2,5,2,2,3,3,2,4,4,2,2,3,2,5,4,5,3,2,5,3,3,4,3,4,4,3,3,4,1,5,5,4,1,4,3,3,5,2,1,4]
}

df = pd.DataFrame(data)

# The three variables are all Likert‑scale (1‑5) → treat them as categories

plot_three_vars_box(
    df,
    vars_list=['Ogólna wiedza', 'Wiedza o bezpieczeństwie', 'Wiedza o interakcjach'],
    title='Rozkład odpowiedzi (skala 1‑5) dla trzech zmiennych',
    filename='samoocena.png',
    rotate_xticks=False,
    x_label='Zmienna ankietowa',
    y_label='Ocena (1‑5)',
    palette='Set2',
    show_points=True
)

# ----------------------------------------------------------------------
# Indeks obiektywnej wiedzy
# ----------------------------------------------------------------------

df_indeks= pd.DataFrame({
    'indeks'     : [0, 1, 2, 3, 4, 5, 6],
    'n'       : [2, 6, 12, 11, 28.87, 39.18, 0],
    'procent' : [2.06, 6.19, 12.37, 11.34, 28.87, 39.18, 0]
})
plot_bar(df_indeks,
         'indeks',
         'n',
         'procent',
         title='Indeks',
         filename='indeks-wiedzy.png',
         rotate_xticks=True,
         x_label='Indeks',
         y_label='Liczba respondentów (n)',
         bar_color='orange')

# ----------------------------------------------------------------------
# Kategorie praktyk
# ----------------------------------------------------------------------

df_kategorie= pd.DataFrame({
    'kategoria'     : ['Niski', 'Umiarkowany', 'Wysoki'],
    'n'       : [20, 39, 38],
    'procent' : [20.61, 40.21, 39.18]
})
plot_bar(df_kategorie,
         'kategoria',
         'n',
         'procent',
         title='Kategorie',
         filename='kategorie-wiedzy.png',
         rotate_xticks=True,
         x_label='Poziom wiedzy',
         y_label='Liczba respondentów (n)',
         bar_color='orange')

